import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/app/weather/domain/entities/current_weather_data.dart';
import 'package:weather_app/app/weather/presentation/controllers/weather_cubit.dart';
import 'package:weather_app/app/weather/presentation/widgets/weather_widget.dart';
import 'package:weather_app/core/modules/weather_module.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/injection.dart';

class WeatherHomePage extends StatelessWidget {
  //controller of page view
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  // animation duration when scrolling
  final Duration _nextAnimationDuration = Duration(milliseconds: 550);

  WeatherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => locator<WeatherCubit>(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            top: false,
            bottom: false,
            child: (state.isLoading)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : (state.weatherList.isEmpty)
                    ? Center(
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Text.rich(
                              TextSpan(
                                text:
                                    "Actuellement, aucune donnée n'est disponible. Veuillez sélectionner une ville pour poursuivre.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Choisir une ville',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        WeatherModuleRoute.weatherList
                                            .push()
                                            .then((value) => context
                                                .read<WeatherCubit>()
                                                .getWeathers());
                                      },
                                  ),
                                ],
                              ),
                              textAlign: TextAlign
                                  .center, // Alignment for the entire Text.rich
                            )))
                    : Stack(
                        children: [
                          //   10.SizedBox(height: 10,),,
                          PageView.builder(
                              controller: pageController,
                              itemCount: state.weatherList.length,

                              itemBuilder: (context, position) {
                                return PageViewItem(
                                  data: state.weatherList[position],
                                  fiveDayDataList: state.fiveDayDataList,
                                );
                              }),
                          if (state.weatherList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: IndicatorWidget(
                                  length: state.weatherList.length,
                                  topController: pageController,
                                ),
                              ),
                            ),
                        ],
                      ),
          ));
        },
      ),
    );
  }
}

/// pageView indicator widget
class IndicatorWidget extends StatelessWidget {
  final PageController topController;
  final int length;

  const IndicatorWidget({
    super.key,
    required this.topController,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("SmoothPageIndicator length is : $length");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmoothPageIndicator(
          controller: topController,
          count: length,

          effect: ScrollingDotsEffect(
              spacing: 8.0,
              radius: 7.5,
              dotWidth: 15.0,
              dotHeight: 15.0,
              activeStrokeWidth: 2.6,
              activeDotScale: 1.3,
              dotColor: Colors.grey,
              activeDotColor: Colors.blue),
        ),
      ],
    );
  }
}

class PageViewItem extends StatelessWidget {
  final CurrentWeatherData data;
  final List<CurrentWeatherData> fiveDayDataList;
  const PageViewItem(
      {Key? key, required this.data, required this.fiveDayDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherWidget(
        currentWeatherData: data, fiveDayDataList: fiveDayDataList);
  }
}
