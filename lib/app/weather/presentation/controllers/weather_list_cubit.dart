import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/constants/app_const.dart';
import 'package:weather_app/core/services/shared_preferences_service.dart';
import 'package:weather_app/core/services/snackbar_service.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/injection.dart';

import '../../domain/entities/current_weather_data.dart';
import '../../domain/usecases/get_weather_by_city.dart';

@injectable
class WeatherListCubit extends Cubit<WeatherListState> {

  final SnackbarService _snackbarService = locator<SnackbarService>();
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final GetWeatherByCity _getWeatherByCity = locator<GetWeatherByCity>();
  final TextEditingController searchController = TextEditingController();

  List<String> cities = List.empty(growable: true);
  List<CurrentWeatherData> _weathers = List.empty(growable: true);

  WeatherListCubit() : super(WeatherListState()) {
    getWeathers();
  }

  void getWeathers() {
    _weathers.clear();
    cities = List<String>.from(_sharedPreferencesService.getFromDisk(cityListKey) ?? []) ;
    if (cities.isNotEmpty) {
      for (String city in cities) {
        getWeatherByCity(city: city);
      }
    }
  }

  void getWeatherByCity({required String city}) {
    Task(() => _getWeatherByCity(city))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((either) => {
              either.fold(
                  (failure) => {
                        debugPrint('getWeatherByCity : $failure'),
                    _snackbarService.showErrorSnackbar(failure.description)
                      },
                  (value) => {
                        debugPrint('getWeatherByCity& success : $value'),
                    _weathers.insert(0,value),
                        _updateState()
                      }),
            });
  }

  void saveCity({required String city}) {
    if(cities.contains(city.toLowerCase())){
      getWeathers();
    }else{
      cities.add(city.toLowerCase());
      _sharedPreferencesService.saveModelToDisk(cityListKey, cities);
      getWeathers();
    }

  }

  _updateState() {
    emit(WeatherListState(weathers: _weathers));
  }
}

class WeatherListState {
  List<CurrentWeatherData> weathers;
  WeatherListState({List<CurrentWeatherData>? weathers})
      : weathers = weathers ?? [];
}
