import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/cities.dart';
import '../../../../core/errors/failure.dart';
import '../entities/city.dart';
import '../entities/weather.dart';

abstract class GetCurrentWeather {
  Future<Either<Failure, Weather>> getWeather(Coordinates coordinates);
  Future<Either<Failure, List<City>>> allCities();
} 

class GetCurrentWeatherImpl implements GetCurrentWeather {

  final WeatherRepository weatherRepository;

  GetCurrentWeatherImpl({required this.weatherRepository});

  @override
  Future<Either<Failure, Weather>> getWeather(Coordinates coordinates) async {
    return weatherRepository.getCurrent(coordinates);
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
          cities[i].currentWeather = r;
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