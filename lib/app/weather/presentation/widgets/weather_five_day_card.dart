import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/assets_path.dart';
import '../../domain/entities/current_weather_data.dart';
import '../../domain/entities/five_days_data.dart';
import 'package:intl/intl.dart';

class WeatherFiveDayCard extends StatelessWidget {
  final CurrentWeatherData currentWeatherData ;
  const WeatherFiveDayCard({super.key , required this.currentWeatherData});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 15, left: 20, right: 20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(currentWeatherData.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(
                        color: Colors.black45,
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold,
                        fontFamily:
                        'flutterfonts',
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      DateFormat()
                          .add_MMMMEEEEd()
                      .add_Hm()
                          .format(DateTime.fromMillisecondsSinceEpoch(currentWeatherData.dt! * 1000)),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(
                        color: Colors.black45,
                        fontSize: 16,
                        fontFamily:
                        'flutterfonts',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            (currentWeatherData.weather != null)  ? Row(
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
                          fontFamily:
                          'flutterfonts',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('${(currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(
                            color: Colors.black45,
                            fontFamily:
                            'flutterfonts'),
                      ),
                      Text(
                        'min: ${(currentWeatherData.main!.tempMin! - 273.15).
                        round().toString()}\u2103 / max: ${(currentWeatherData.main!.tempMax! - 273.15)
                            .round().toString()}\u2103',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold,
                          fontFamily:
                          'flutterfonts',
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
                          child: LottieBuilder.asset(
                              cloudyAnim),
                        ),
                        Text(
                          'Vent : ${currentWeatherData.wind!.speed} m/s',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight:
                            FontWeight.bold,
                            fontFamily:
                            'flutterfonts',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) :const Center(child: CircularProgressIndicator(),),
          ],
        ),
      ),
    );
  }
}
