import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/weather/presentation/controllers/weather_list_cubit.dart';
import 'package:weather_app/app/weather/presentation/widgets/weather_five_day_card.dart';
import 'package:weather_app/injection.dart';

class WeatherListPage extends StatelessWidget {
  const WeatherListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherListCubit>(
      create: (context) => locator<WeatherListCubit>(),
      child: BlocBuilder<WeatherListCubit, WeatherListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Weather App'),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller:
                      context.read<WeatherListCubit>().searchController,
                      onSubmitted: (value){
                        context.read<WeatherListCubit>().saveCity(city: value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText: 'Choisir une ville...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  if (state.weathers.isEmpty)
                    Center(
                      child: Text("Aucune ville trouvée"),
                    )
                  else
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ListView.builder(
                          itemCount: state.weathers.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              WeatherFiveDayCard(
                                  currentWeatherData: state.weathers[index]),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}