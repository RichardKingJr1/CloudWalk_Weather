// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherState {}

class ForecastWeatherSuccess implements ForecastWeatherState {
  final List<City> cities;
  final List<City> filteredCities;

  ForecastWeatherSuccess({required this.cities, required this.filteredCities});


  ForecastWeatherSuccess copyWith({
    List<City>? cities,
    List<City>? filteredCities,
  }) {
    return ForecastWeatherSuccess(
      cities: cities ?? this.cities,
      filteredCities: filteredCities ?? this.filteredCities,
    );
  }
}

class ForecastWeatherInitial implements ForecastWeatherState {}
class ForecastWeatherLoading implements ForecastWeatherState {}
class ForecastWeatherError implements ForecastWeatherState {}

