import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/app/weather/data/models/main_weather_model.dart';
import 'package:weather_app/app/weather/data/models/sys_model.dart';
import 'package:weather_app/app/weather/data/models/weather_model.dart';
import 'package:weather_app/app/weather/data/models/wind_model.dart';

import 'package:weather_app/app/weather/data/models/clouds_model.dart';
import 'package:weather_app/app/weather/data/models/coord_model.dart';

import '../../domain/entities/current_weather_data.dart';

part 'current_weather_data_model.g.dart';

@JsonSerializable()
class CurrentWeatherDataModel {
  final CoordModel? coord;
  final List<WeatherModel>? weather;
  final String? base;
  final MainWeatherModel? main;
  final int? visibility;
  final WindModel? wind;
  final CloudsModel? clouds;
  final int? dt;
  final SysModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeatherDataModel(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  factory CurrentWeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherDataModelToJson(this);

  CurrentWeatherData toEntity() {
    return CurrentWeatherData(
      main: main?.toEntity(),
      id: id,
      name: name,
      base: base,
      clouds: clouds?.toEntity(),
      cod: cod,
      coord: coord?.toEntity(),
      dt: dt,
      sys: sys?.toEntity(),
      timezone: timezone,
      visibility: visibility,
      weather: weather?.map((e) => e.toEntity()).toList(),
      wind: wind?.toEntity(),
    );
  }
}
