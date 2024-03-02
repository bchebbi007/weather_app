import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app/weather/presentation/controllers/weather_cubit.dart';
import 'package:weather_app/app/weather/presentation/widgets/weather_card.dart';
import 'package:weather_app/app/weather/presentation/widgets/weather_five_day_card.dart';

import 'package:weather_app/core/constants/assets_path.dart';
import '../../../../injection.dart';
import '../../domain/entities/current_weather_data.dart';

class WeatherWidget extends StatelessWidget {
  final CurrentWeatherData currentWeatherData ;
  final List<CurrentWeatherData> fiveDayDataList ;
  const WeatherWidget({super.key , required this.currentWeatherData , required this.fiveDayDataList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: WeatherCard(currentWeatherData: currentWeatherData)

            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: EdgeInsets.only(top: 120),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Prévisions pour les 5 prochains jours',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  WeatherFiveDayCard(
                                      currentWeatherData:
                                      fiveDayDataList[index]),
                              separatorBuilder: (context, index) => SizedBox(width: 20,),
                              itemCount: fiveDayDataList.length),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
