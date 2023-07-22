import 'package:cloudwalk_weather/core/errors/failure.dart';
import 'package:cloudwalk_weather/modules/weather/data/datasources/weather_datasource.dart';
import 'package:cloudwalk_weather/modules/weather/data/models/weather_model.dart';
import 'package:cloudwalk_weather/modules/weather/data/repositories/weather_repository_impl.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/weather.dart';
import 'package:cloudwalk_weather/modules/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class WeatherDatasourceMock extends  Mock implements WeatherDatasource {}

void main() {
  
  group('description', () { 

    WeatherDatasource weatherDatasourceMock = WeatherDatasourceMock();
    WeatherRepository weatherRepository = WeatherRepositoryImpl(weatherDatasource: weatherDatasourceMock);


    test('Dadas as coordenadas, ao buscar o clima atual, deve retornar weather quando for Right', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      final weather = WeatherModel(dt: DateTime.now(), temp: 1, temp_max: 1, temp_min: 1, weather_main: 'weather_main', icon: 'icon');
      when(() => weatherDatasourceMock.getCurrent(coordinates)).thenAnswer((_) async => weather);

      final response = await weatherRepository.getCurrent(coordinates);

      expect(response.getOrElse(() => throw Exception()), isA<Weather>());
    });

    test('Dadas as cordenadas, ao buscar o clima atual e ocorrer um erro, espera que seja retornado um Failure ', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      when(() => weatherDatasourceMock.getForecast(coordinates)).thenAnswer((_) async => throw Exception());

      final response = await weatherRepository.getCurrent(coordinates);

      expect(response.fold(id,id), isA<Failure>());

    });
  });

}