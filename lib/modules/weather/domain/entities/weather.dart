// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {

  DateTime dt;
  double temp;
  double temp_max;
  double temp_min;
  String weather_main;
  String icon;
  
  Weather({
    required this.dt,
    required this.temp,
    required this.temp_max,
    required this.temp_min,
    required this.weather_main,
    required this.icon,
  });
  

}
