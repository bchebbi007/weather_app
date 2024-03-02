
import 'package:injectable/injectable.dart';
import 'package:weather_app/app/weather/domain/entities/five_days_data.dart';
import 'package:weather_app/core/usecase/base_usecase.dart';

import '../../../../injection.dart';
import '../../data/repository/weather_repository.dart';
import '../entities/current_weather_data.dart';

@LazySingleton()
class GetFiveDayData extends BaseUseCase<List<CurrentWeatherData>, String> {
  final WeatherRepository _weatherRepository = locator<WeatherRepository>();

  @override
  Future<List<CurrentWeatherData>> call(String parameters) async {
    return await _weatherRepository.getFiveDaysThreeHoursForcastData(city: parameters);
  }
}