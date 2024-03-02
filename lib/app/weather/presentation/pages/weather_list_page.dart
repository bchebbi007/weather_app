import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/weather/presentation/controllers/weather_list_cubit.dart';
import 'package:weather_app/app/weather/presentation/widgets/weather_five_day_card.dart';
import 'package:weather_app/injection.dart';

class WeatherListPage extends StatelessWidget {
  const WeatherListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherListCubit>(
      create: (context) => locator<WeatherListCubit>(),
      child: BlocBuilder<WeatherListCubit, WeatherListState>(
          builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.blue,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0 , right: 20),
                          child: TextField(
                            controller:
                                context.read<WeatherListCubit>().searchController,
                            onSubmitted: (value){
                              context.read<WeatherListCubit>().saveCity(city: value);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              hintText: 'choisir une ville...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.blue, // Set the border color here
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .blue, // Set the focused border color here
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.blue, // Set the icon color here
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      (state.weathers.isEmpty)
                          ? Center(
                              child: Text("Aucune ville trouvée"),
                            )
                          : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0 , right: 20),
                              child: ListView.separated(
                                reverse: true,
                                  itemBuilder: (context, index) => WeatherFiveDayCard(
                                      currentWeatherData: state.weathers[index]),
                                  separatorBuilder: (context, index) => SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: state.weathers.length),
                            ),
                          )
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
