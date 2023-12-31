import 'package:cloudwalk_weather/modules/weather/domain/usecases/filter_cities.dart';
import 'package:cloudwalk_weather/modules/weather/presenter/bloc/forecast_weather/forecast_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/app_botton.dart';
import '../../domain/usecases/check_connectivity.dart';
import '../../domain/usecases/get_forecast_weather.dart';

class ForecastWeatherPage extends StatefulWidget {
  const ForecastWeatherPage({super.key});

  @override
  State<ForecastWeatherPage> createState() => _ForecastWeatherPageState();
}

class _ForecastWeatherPageState extends State<ForecastWeatherPage> {

  final bloc = ForecastWeatherBloc(usecase: GetIt.I.get<GetForecastWeather>(), filterCities:  GetIt.I.get<FilterCities>(), connectivity: GetIt.I.get<CheckConnectivity>());

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
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        final state = bloc.state;

        if(state is ForecastWeatherSuccess) {
           return Scaffold(
            appBar: CustomAppBar(
              onChanged: (value) {
                bloc.add(FilterEvent(text: value));
              },
              refresh: () {
                bloc.add(GetWeatherEvent());
              },
            ),
            bottomNavigationBar: AppBotton(cont: context, selectedIndex: 1),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                  itemCount: state.filteredCities.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 240,
                      child: Card(
                        color: Color.fromARGB(255, 192, 192, 192),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.filteredCities[index].cityName,
                                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 5),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: const NeverScrollableScrollPhysics(),
                                //itemCount: state.filteredCities.length,
                                itemBuilder: (context, ind) {
                                  var indFix = ind * 8;
                                  return Row(
                                    children: [
                                      Text(DateFormat('dd/MM/yy').format(state.filteredCities[index].forecast![indFix].dt)),
                                      //Text(state.filteredCities[index].forecast![indFix].dt.millisecondsSinceEpoch.toString()),
                                      Spacer(),
                                      Image.network(
                                        'http://openweathermap.org/img/wn/${state.filteredCities[index].forecast![indFix].icon}@2x.png',
                                        height: 30,
                                        width: 50,
                                      ),
                                      SizedBox(width: 5),
                                      Text(state.filteredCities[index].forecast![indFix].weather_main),
                                      //SizedBox(width: 15),
                                      //Text(state.filteredCities[index].forecast![ind].temp.toString()),
                                      Spacer(),
                                      Text('${state.filteredCities[index].forecast![indFix].temp_min.toString()}°/${state.filteredCities[index].forecast![ind].temp_max.toString()}°'),
                                      SizedBox(width: 20,)
                                    ],
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          );
        } else if(state is ForecastWeatherConnection) {
          return Scaffold(
            appBar: CustomAppBar(
              onChanged: (value) {
                bloc.add(FilterEvent(text: value));
              },
              refresh: () {
                bloc.add(GetWeatherEvent());
              },
            ),
            bottomNavigationBar: AppBotton(cont: context, selectedIndex: 1),
            body: SafeArea(
              child: Center(
                child: Text('Sem Internet'),
              )
            ),
          );
        } else {
          return Scaffold(
            bottomNavigationBar: AppBotton(cont: context, selectedIndex: 1),
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

