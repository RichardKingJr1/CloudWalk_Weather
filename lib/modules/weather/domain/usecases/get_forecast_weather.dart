import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/cities.dart';
import '../../../../core/errors/failure.dart';
import '../entities/city.dart';
import '../entities/weather.dart';

abstract class GetForecastWeather {
  Future<Either<Failure, List<Weather>>> getWeather(Coordinates coordinates);
  Future<Either<Failure, List<City>>> allCities();
} 

class GetForecastWeatherImpl implements GetForecastWeather {

  final WeatherRepository weatherRepository;

  GetForecastWeatherImpl({required this.weatherRepository});

  @override
  Future<Either<Failure, List<Weather>>> getWeather(Coordinates coordinates) async {
    return weatherRepository.getForecast(coordinates);
  }

  @override
  Future<Either<Failure, List<City>>> allCities() async {
    var cities = concertList;
    Failure? failureCtrl = null;

    for(var i = 0; i < cities.length; i++) {
      final response = await getWeather(cities[i].coordinates);
      response.fold(
        (l) {
          failureCtrl = l;
        }, 
        (r) {
          cities[i].forecast = r;
        }
      );
    }

    if (failureCtrl != null) {
      return Left(failureCtrl!);
    } else {
      return Right(cities);
    } 
  }

  

}