import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/weather/domain/entities/five_days_data.dart';
import 'package:weather_app/core/constants/app_const.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/injection.dart';

import '../../../../core/services/permission_handler_service.dart';
import '../../../../core/services/shared_preferences_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/services/snackbar_service.dart';
import '../../domain/entities/current_weather_data.dart';
import '../../domain/usecases/get_five_day_data.dart';
import '../../domain/usecases/get_weather_by_city.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final LocationService _locationService = locator<LocationService>();
  final PermissonHandlerService _permissonHandlerService =
  locator<PermissonHandlerService>();
  final GetWeatherByCity _getWeatherByCity = locator<GetWeatherByCity>();



  final GetFiveDayData _getFiveDayData = locator<GetFiveDayData>();

  List<CurrentWeatherData> _weatherList = List.empty(growable: true);
  List<CurrentWeatherData> _fiveDayDataList = List.empty(growable: true);
   List<String> _cities = List.empty(growable: true);

  Position? _currentPosition;
  Placemark? place;
  bool _isLoading = false ;
  WeatherCubit() : super(WeatherState()) {

    getWeathers();
  }

  void getWeathers() {
    _isLoading = true;
    _weatherList.clear();
    _fiveDayDataList.clear();
    _updateState();
    _cities = List<String>.from(_sharedPreferencesService.getFromDisk(cityListKey) ?? []) ;
    getPermission();
    if (_cities.isNotEmpty) {
      for (String city in _cities) {
        getWeatherByCity(city: city);
        getFiveDayData(city: city);
      }
    }
  }
  void getUserCurrentCity() {
    Task(() => _locationService.getCity(_currentPosition!))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((either) => {
              either.fold(
                  (failure) => {
                    _isLoading = false ,
                    _updateState(),
                        debugPrint('getUserCurrentCity : $failure'),
                      },
                  (position) => {
                        debugPrint('getUserCurrentCity success : $position'),
                        place = position,
                        if (place?.locality != null)
                          {

                            getWeatherByCity( city: place!.locality!),
                            getFiveDayData(
                              city: place!.locality!,
                            )
                          }else {
                          _isLoading = false ,
                          _updateState(),
                        }
                      }),
            });
  }

  void getUserCurrentLocation() {
    Task(() => _locationService.getCurrentLocation())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((either) => {
              either.fold(
                  (failure) => {
                    _isLoading = false ,
                    _updateState(),
                        debugPrint('getUserCurrentLocation : $failure'),
                      },
                  (position) => {
                        debugPrint(
                            'getUserCurrentLocation success : $position'),
                        _currentPosition = position,
                        if (_currentPosition != null)
                          {
                            getUserCurrentCity()
                          }else{
                          _isLoading = false ,
                          _updateState(),
                          _snackbarService.showErrorSnackbar("Veuillez activer la localisation pour profiter pleinement des fonctionnalités de l'application.")
                    },
                      }),
            });
  }


  void getWeatherByCity({required String city}){
    Task(() => _getWeatherByCity(city))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((either) => {
      either.fold(
              (failure) => {
                _isLoading = false ,
                _updateState(),
            debugPrint('getWeatherByCity : $failure'),
                _snackbarService.showErrorSnackbar(failure.description)
          },
              (value) => {
                _isLoading = false ,
                _updateState(),
            debugPrint(
                'getWeatherByCity& success : $value'),
            _weatherList.add(value),
            _updateState()
          }),
    });
  }
  void getFiveDayData({required String city}) {
    Task(() => _getFiveDayData(city))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((either) => {
              either.fold(
                  (failure) => {
                        debugPrint('getFiveDayData : $failure'),
                    _snackbarService.showErrorSnackbar(failure.description)
                      },
                  (value) => {
                        debugPrint('getFiveDayData success : $value'),
                        _fiveDayDataList.addAll(value),
                        _updateState()
                      }),
            });
  }


  void getPermission() {
    Task(() => _permissonHandlerService.requestPermission())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((either) => {
      either.fold(
              (failure) => {
                _isLoading = false ,
              _updateState(),
            debugPrint('getPermission failure : $failure'),
          },
              (status) => {

                debugPrint('getPermission success : $status'),
              getUserCurrentLocation(),
          }),
    });
  }

  _updateState() {
    emit(WeatherState(
        fiveDayDataList: _fiveDayDataList,
isLoading: _isLoading,
        weatherList: _weatherList));
  }
}

class WeatherState {
  List<CurrentWeatherData> weatherList;
  List<CurrentWeatherData> fiveDayDataList;
  bool isLoading ;

  WeatherState(
      {List<CurrentWeatherData>? weatherList,
      List<CurrentWeatherData>? fiveDayDataList,
        this.isLoading = false
      })
      : weatherList = weatherList ?? [],
        fiveDayDataList = fiveDayDataList ?? [];
}
