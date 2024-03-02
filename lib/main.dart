import 'package:flutter/material.dart';
import 'package:weather_app/core/managers/snackbar_manager.dart';
import 'package:weather_app/core/services/navigation_service.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/router.dart' as router;
import 'app/weather/presentation/pages/weather_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      navigatorKey: locator<NavigationService>().navigationKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.onGenerateRoute,
      theme: ThemeData(),
      home:  SnackbarManager(child: WeatherHomePage()),
    );
  }
}
