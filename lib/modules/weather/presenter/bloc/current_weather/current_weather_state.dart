// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {}

class CurrentWeatherSuccess implements CurrentWeatherState {
  final List<City> cities;

  CurrentWeatherSuccess(this.cities);


}

class CurrentWeatherInitial implements CurrentWeatherState {}
class CurrentWeatherLoading implements CurrentWeatherState {}
class CurrentWeatherError implements CurrentWeatherState {}


