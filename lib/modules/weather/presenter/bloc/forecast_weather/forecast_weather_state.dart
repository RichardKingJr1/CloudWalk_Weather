part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherState {}

class ForecastWeatherSuccess implements ForecastWeatherState {
  final List<City> cities;

  ForecastWeatherSuccess(this.cities);

}

class ForecastWeatherInitial implements ForecastWeatherState {}
class ForecastWeatherLoading implements ForecastWeatherState {}
class ForecastWeatherError implements ForecastWeatherState {}

