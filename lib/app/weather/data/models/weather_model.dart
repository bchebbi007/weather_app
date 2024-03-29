import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherModel({this.id, this.main, this.description, this.icon});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  Weather toEntity() {
    return Weather(
      id: id,
      description: description,
      icon: icon,
      main: main,
    );
  }
}
