// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'coodinates.dart';
import 'weather.dart';

class City {

  String cityName;
  Coordinates coordinates;
  Weather? currentWeather;
  List<Weather>? forecast;

  City({
    required this.cityName,
    required this.coordinates,
    this.currentWeather,
    this.forecast,
  });

}
