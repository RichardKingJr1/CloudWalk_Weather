
import 'package:cloudwalk_weather/modules/weather/domain/usecases/filter_cities.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/get_current_weather.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/app_botton.dart';
import '../bloc/current_weather/current_weather_bloc.dart';

class CurrentWeatPage extends StatefulWidget {
  const CurrentWeatPage({super.key});

  @override
  State<CurrentWeatPage> createState() => _CurrentWeatPageState();
}

class _CurrentWeatPageState extends State<CurrentWeatPage> {

  final bloc = CurrentWeatherBloc(usecase: GetIt.I.get<GetCurrentWeather>(), filterCities: GetIt.I.get<FilterCities>());

  @override
  void initState() {
    // TODO: implement initState
    bloc.add(GetWeatherEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CurrentWeatherState>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        final state = bloc.state;
        if(state is CurrentWeatherSuccess) {
          return Scaffold(
            appBar: CustomAppBar(
              onChanged: (value) {
                bloc.add(FilterEvent(text: value));
              },
              refresh: () {
                bloc.add(GetWeatherEvent());
              },
            ),
            bottomNavigationBar: AppBotton(cont: context, selectedIndex: 0),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = state.filteredCities[index];
                    return Container(
                      height: 170,
                      child: Card(
                        color: Color.fromARGB(255, 192, 192, 192),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10,left: 20.0),
                                child: Text(
                                  city.cityName,
                                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Image.network(
                                    'http://openweathermap.org/img/wn/${city.currentWeather!.icon}@2x.png',
                                    height: 75,
                                    width: 75,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${city.currentWeather!.temp.toString()}°",
                                    style: const TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(city.currentWeather!.weather_main),
                                      Text('min: ${city.currentWeather!.temp_min.toString()}°'),
                                      Text('max: ${city.currentWeather!.temp_max.toString()}°'),
                                    ],
                                  ),
                                  SizedBox(width: 20,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            bottomNavigationBar: AppBotton(cont: context, selectedIndex: 0),
            body: SafeArea(
              child: Center(
                child: Text('Carregando'),
              )
            ),
          );
        }
        
      }
    );
  }
  
}
