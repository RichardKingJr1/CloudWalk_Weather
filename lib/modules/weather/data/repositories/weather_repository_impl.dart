import 'package:dartz/dartz.dart';


import '../../../../core/errors/failure.dart';
import '../../domain/entities/coodinates.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_datasource.dart';


class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDatasource weatherDatasource;

  WeatherRepositoryImpl({required this.weatherDatasource});

  @override
  Future<Either<Failure, Weather>> getCurrent(Coordinates coordinates) async {
    try {
      final response = await weatherDatasource.getCurrent(coordinates);
      return Right(response);
    } catch (e) {
      return Left(Failure(title: 'Erro no get Current', message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Weather>>> getForecast(Coordinates coordinates) async {
    // Implementation for getForecast
    try {
      final response = await weatherDatasource.getForecast(coordinates);
      return Right(response);
    } catch (e) {
      return Left(Failure(title: 'Erro no get Current', message: e.toString()));
    }
  }
}
