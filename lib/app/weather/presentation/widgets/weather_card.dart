import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app/weather/domain/entities/current_weather_data.dart';
import 'package:weather_app/app/weather/presentation/controllers/weather_cubit.dart';
import 'package:weather_app/core/modules/weather_module.dart';

import '../../../../core/constants/assets_path.dart';

class WeatherCard extends StatelessWidget {
  final CurrentWeatherData currentWeatherData;
  const WeatherCard({super.key, required this.currentWeatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          image: AssetImage(
            blueSky,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.black,
              ),
              onPressed: () {
                WeatherModuleRoute.weatherList.push().then(
                        (value) => context.read<WeatherCubit>().getWeathers());
              },
            ),],

          ),
          Align(
            alignment: const Alignment(0.0, 1.0),
            child: SizedBox(
              height: 10,
              width: 10,
              child: OverflowBox(
                minWidth: 0.0,
                maxWidth: MediaQuery.of(context).size.width,
                minHeight: 0.0,
                maxHeight: (MediaQuery.of(context).size.height / 3),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: double.infinity,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.only(top: 15, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  '${currentWeatherData.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black45,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'flutterfonts',
                                      ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  DateFormat()
                                      .add_MMMMEEEEd()
                                      .format(DateTime.now()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontFamily: 'flutterfonts',
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        (currentWeatherData.weather != null)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          '${currentWeatherData.weather![0].description}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: Colors.black45,
                                                fontSize: 22,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${(currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  color: Colors.black45,
                                                  fontFamily: 'flutterfonts'),
                                        ),
                                        Text(
                                          'min: ${(currentWeatherData.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(currentWeatherData.main!.tempMax! - 273.15).round().toString()}\u2103',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: Colors.black45,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 120,
                                            height: 120,
                                            child:
                                                LottieBuilder.asset(cloudyAnim),
                                          ),
                                          Text(
                                            'Vent : ${currentWeatherData.wind!.speed} m/s',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: Colors.black45,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'flutterfonts',
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
