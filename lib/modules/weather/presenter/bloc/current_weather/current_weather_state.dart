// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {}

class CurrentWeatherSuccess implements CurrentWeatherState {
  final List<City> cities;
  final List<City> filteredCities;

  CurrentWeatherSuccess({required this.filteredCities, required this.cities});


  CurrentWeatherSuccess copyWith({
    List<City>? cities,
    List<City>? filteredCities,
  }) {
    return CurrentWeatherSuccess(
      cities: cities ?? this.cities,
      filteredCities: filteredCities ?? this.filteredCities,
    );
  }
}

class CurrentWeatherInitial implements CurrentWeatherState {}
class CurrentWeatherLoading implements CurrentWeatherState {}
class CurrentWeatherError implements CurrentWeatherState {}


