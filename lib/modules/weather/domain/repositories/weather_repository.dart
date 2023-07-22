import 'package:cloudwalk_weather/core/errors/failure.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

import '../entities/coodinates.dart';

abstract class WeatherRepository {

  Future<Either<Failure, Weather>> getCurrent(Coordinates coordinates);

  Future<Either<Failure, List<Weather>>> getForecast(Coordinates coordinates);

}
