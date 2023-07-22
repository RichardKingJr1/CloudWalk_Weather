import 'package:cloudwalk_weather/core/errors/failure.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/weather.dart';
import 'package:cloudwalk_weather/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/get_forecast_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class WeatherRepositoryMock extends  Mock implements WeatherRepository {}

void main() {

  final mockWeatherRepository =  WeatherRepositoryMock();
  final getForecastWeather = GetForecastWeatherImpl(weatherRepository: mockWeatherRepository);


  group('description', () { 
    test('Dadas as cordenadas, expera que seja retornado uma Lista de Weathers ', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      final forecastWeather = <Weather>[];
      when(() => mockWeatherRepository.getForecast(coordinates)).thenAnswer((_) async => Right(forecastWeather));

      final response = await getForecastWeather(coordinates);

      expect(response.getOrElse(() => throw Exception()), isA<List<Weather>>());

    });

    test('Dadas as cordenadas, expera que seja retornado um Failure ', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      final failure = Failure(title: 'title', message: 'message');
      when(() => mockWeatherRepository.getForecast(coordinates)).thenAnswer((_) async => Left(failure));

      final response = await getForecastWeather(coordinates);

      expect(response.fold(id,id), isA<Failure>());

    });
  });

  

}