

import '../../data/models/current_weather_data_model.dart';
import '../../data/models/five_days_data_model.dart';
import '../entities/current_weather_data.dart';
import '../entities/five_days_data.dart';


abstract class BaseWeatherRepository {
  Future<CurrentWeatherData> getCurrentWeatherByCity(
      {required String city});

  Future<CurrentWeatherData> getCurrentWeatherByPosition(
      {required double lat, required double long});

  Future<List<CurrentWeatherData>> getFiveDaysThreeHoursForcastData({required String city});
}