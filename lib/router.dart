import 'package:flutter/cupertino.dart';
import 'package:weather_app/core/modules/weather_module.dart';


Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name?.startsWith("weather/") ?? false) {
    return WeatherModule.routeFactory(settings);
  }



}