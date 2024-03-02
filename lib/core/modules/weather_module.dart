import 'package:flutter/cupertino.dart';

import '../../app/weather/presentation/pages/weather_home_page.dart';
import '../../app/weather/presentation/pages/weather_list_page.dart';
import '../../injection.dart';
import '../security/restricted_material_page_route.dart';
import '../services/navigation_service.dart';

class WeatherModule {
  static RouteFactory get routeFactory => (RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case 'weather/weatherHomePage':
        builder = (BuildContext context) => WeatherHomePage();
        var route = RestrictedMaterialPageRoute<bool>(
            builder: builder, settings: settings);
        return route;
      case 'weather/weatherList':
        builder = (BuildContext context) => WeatherListPage();
        var route = RestrictedMaterialPageRoute<bool>(
            builder: builder, settings: settings);
        return route;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  };
}

enum WeatherModuleRoute { weatherHomePage , weatherList}

extension WeatherModuleRouteExtension on WeatherModuleRoute {
  String get name {
    switch (this) {
      case WeatherModuleRoute.weatherHomePage:
        return 'weather/weatherHomePage';

      case WeatherModuleRoute.weatherList:
        return 'weather/weatherList';
    }
  }

  Future<T?> push<T extends Object?>({Object? args}) =>
      locator<NavigationService>().navigateTo<T>(name, arguments: args);

  Future pushReplacement<T extends Object?>({Object? args}) {
    return locator<NavigationService>()
        .navigateToAndReplace(name, arguments: args);
  }
}
