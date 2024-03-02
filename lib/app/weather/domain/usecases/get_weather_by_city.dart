import 'package:injectable/injectable.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../injection.dart';
import '../../data/models/current_weather_data_model.dart';
import '../../data/repository/weather_repository.dart';
import '../entities/current_weather_data.dart';

@LazySingleton()
class GetWeatherByCity extends BaseUseCase<CurrentWeatherData, String> {
  final WeatherRepository _weatherRepository = locator<WeatherRepository>();

  @override
  Future<CurrentWeatherData> call(String parameters) async {
    return await _weatherRepository.getCurrentWeatherByCity(city: parameters);
  }
}
