import 'package:cloudwalk_weather/core/errors/failure.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/weather.dart';
import 'package:cloudwalk_weather/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class WeatherRepositoryMock extends  Mock implements WeatherRepository {}

void main() {

  final mockWeatherRepository =  WeatherRepositoryMock();
  final getCurrentWeather = GetCurrentWeatherImpl(weatherRepository: mockWeatherRepository);


  test('Dadas as cordenadas, expera que seja retornado uma viavel tipo Weather ', () async {

    Coordinates coordinates = Coordinates(lat: 1, lon: 1);
    final weather = Weather(dt: DateTime.now(), temp: 1, temp_max: 1, temp_min: 1, weather_main: 'weather_main', icon: 'icon');
    when(() => mockWeatherRepository.getCurrent(coordinates)).thenAnswer((_) async => Right(weather));

    final response = await getCurrentWeather(coordinates);

    expect(response.getOrElse(() => throw Exception()), isA<Weather>());

  });

  test('Dadas as cordenadas, expera que seja retornado um Failure ', () async {

    Coordinates coordinates = Coordinates(lat: 1, lon: 1);
    final failure = Failure(title: 'title', message: 'message');
    when(() => mockWeatherRepository.getCurrent(coordinates)).thenAnswer((_) async => Left(failure));

    final response = await getCurrentWeather(coordinates);

    expect(response.fold(id,id), isA<Failure>());

  });

}