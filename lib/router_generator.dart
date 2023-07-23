
import 'package:flutter/material.dart';

import 'modules/weather/presenter/pages/current_weather_page.dart';
import 'modules/weather/presenter/pages/forecast_weather_page.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => CurrentWeatPage());

      case '/forecast':
        return MaterialPageRoute(builder: (_) => ForecastWeatherPage());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
