// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent {}

class GetWeatherEvent implements CurrentWeatherEvent {}

class FilterEvent implements CurrentWeatherEvent {

  final String text;
  FilterEvent({
    required this.text,
  });

}

