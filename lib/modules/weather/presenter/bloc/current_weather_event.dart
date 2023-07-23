// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent {}

class GetWeatherEvent implements CurrentWeatherEvent {

  final Coordinates coordinates;

  GetWeatherEvent({
    required this.coordinates,
  });
}
