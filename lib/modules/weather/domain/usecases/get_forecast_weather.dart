import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/weather.dart';

abstract class GetForecastWeather {
  Future<Either<Failure, List<Weather>>> call(Coordinates coordinates);
} 

class GetForecastWeatherImpl implements GetForecastWeather {

  final WeatherRepository weatherRepository;

  GetForecastWeatherImpl({required this.weatherRepository});

  @override
  Future<Either<Failure, List<Weather>>> call(Coordinates coordinates) async {
    return weatherRepository.getForecast(coordinates);
  }

}