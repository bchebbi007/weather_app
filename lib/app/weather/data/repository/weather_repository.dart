import 'package:injectable/injectable.dart';
import 'package:weather_app/app/weather/data/datasources/weather_datasource.dart';
import 'package:weather_app/app/weather/data/models/current_weather_data_model.dart';
import 'package:weather_app/app/weather/domain/entities/five_days_data.dart';
import 'package:weather_app/app/weather/domain/repository/base_weather_repository.dart';
import 'package:weather_app/injection.dart';

import '../../domain/entities/current_weather_data.dart';
import '../models/five_days_data_model.dart';

@LazySingleton()
class WeatherRepository extends BaseWeatherRepository {
  final BaseWeatherDatasource _baseWeatherDatasource =
      locator<BaseWeatherDatasource>();

  @override
  Future<CurrentWeatherData> getCurrentWeatherByCity(
      {required String city}) async {
    CurrentWeatherDataModel _currentData =
        await _baseWeatherDatasource.getCurrentWeatherByCity(city: city);
    return _currentData.toEntity();
  }

  @override
  Future<CurrentWeatherData> getCurrentWeatherByPosition(
      {required double lat, required double long}) async {
    CurrentWeatherDataModel _currentData = await _baseWeatherDatasource
        .getCurrentWeatherByPosition(lat: lat, long: long);

    return _currentData.toEntity();
  }

  @override
  Future<List<CurrentWeatherData>> getFiveDaysThreeHoursForcastData(
      {required String city}) async {
    List<CurrentWeatherDataModel> list = await _baseWeatherDatasource
        .getFiveDaysThreeHoursForcastData(city: city);
    return list.map((e) => e.toEntity()).toList();
  }
}
