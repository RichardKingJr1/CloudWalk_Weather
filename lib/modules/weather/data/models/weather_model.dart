// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloudwalk_weather/modules/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  
  DateTime dt;
  double temp;
  double temp_max;
  double temp_min;
  String weather_main;
  String icon;

  WeatherModel({
    required this.dt,
    required this.temp,
    required this.temp_max,
    required this.temp_min,
    required this.weather_main,
    required this.icon,
  }) :super(
    dt: dt,
    temp: temp,
    temp_max: temp_max,
    temp_min: temp_min,
    weather_main: weather_main,
    icon: icon
  );
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt.millisecondsSinceEpoch,
      'temp': temp,
      'temp_max': temp_max,
      'temp_min': temp_min,
      'weather_main': weather_main,
      'icon': icon,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      dt: DateTime.fromMillisecondsSinceEpoch(map['dt'] as int),
      temp: map['main']['temp'] as double,
      temp_max: map['main']['temp_max'] as double,
      temp_min: map['main']['temp_min'] as double,
      weather_main: map['weather'][0]['main'] as String,
      icon: map['weather'][0]['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
