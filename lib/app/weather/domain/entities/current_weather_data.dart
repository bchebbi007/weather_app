import 'package:weather_app/app/weather/domain/entities/sys.dart';
import 'package:weather_app/app/weather/domain/entities/weather.dart';
import 'package:weather_app/app/weather/domain/entities/wind.dart';
import 'package:weather_app/app/weather/domain/entities/clouds.dart';
import 'package:weather_app/app/weather/domain/entities/coord.dart';
import 'package:weather_app/app/weather/domain/entities/main_weather.dart';

class CurrentWeatherData {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeather? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeatherData(
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


}
