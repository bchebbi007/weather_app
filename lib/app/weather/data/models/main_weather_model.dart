import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/main_weather.dart';

part 'main_weather_model.g.dart';

@JsonSerializable()
class MainWeatherModel {
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'temp_max')
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  MainWeatherModel(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});

  factory MainWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainWeatherModelToJson(this);


  MainWeather toEntity() {
    return MainWeather(
      feelsLike: feelsLike,
      humidity: humidity,
      pressure: pressure,
      temp: temp,
      tempMax: tempMax,
      tempMin: tempMin,
    );
  }
}
