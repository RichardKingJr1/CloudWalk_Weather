// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherEvent {}

class GetWeatherEvent implements ForecastWeatherEvent {}

class FilterEvent implements ForecastWeatherEvent {

  final String text;
  FilterEvent({
    required this.text,
  });

}


