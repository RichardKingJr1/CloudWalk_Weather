import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/weather.dart';

abstract class GetCurrentWeather {
  Future<Either<Failure, Weather>> call(Coordinates coordinates);
} 

class GetCurrentWeatherImpl implements GetCurrentWeather {

  final WeatherRepository weatherRepository;

  GetCurrentWeatherImpl({required this.weatherRepository});

  @override
  Future<Either<Failure, Weather>> call(Coordinates coordinates) async {
    return weatherRepository.getCurrent(coordinates);
  }

}