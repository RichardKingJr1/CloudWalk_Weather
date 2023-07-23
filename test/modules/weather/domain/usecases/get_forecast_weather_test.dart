import 'package:cloudwalk_weather/core/errors/failure.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/city.dart';
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

  setUpAll(() {
    registerFallbackValue(Coordinates(lat: 0, lon: 0)); // Replace with the default values for your test
  });

  group('description', () { 
    test('Dadas as cordenadas, expera que seja retornado uma Lista de Weathers ', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      final forecastWeather = <Weather>[];
      when(() => mockWeatherRepository.getForecast(coordinates)).thenAnswer((_) async => Right(forecastWeather));

      final response = await getForecastWeather.getWeather(coordinates);

      expect(response.getOrElse(() => throw Exception()), isA<List<Weather>>());

    });

    test('Dadas as cordenadas, expera que seja retornado um Failure ', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      final failure = Failure(title: 'title', message: 'message');
      when(() => mockWeatherRepository.getForecast(coordinates)).thenAnswer((_) async => Left(failure));

      final response = await getForecastWeather.getWeather(coordinates);

      expect(response.fold(id,id), isA<Failure>());

    });
  });

  group('getCities', () {

    test('Dadas as cidades, retorna as cidades com o clima atual das cidades ', () async {
      final weather = Weather(dt: DateTime.now(), temp: 1, temp_max: 1, temp_min: 1, weather_main: 'weather_main', icon: 'icon');
      when(() => mockWeatherRepository.getForecast(any())).thenAnswer((_) async => Right([weather]));
      final response = await getForecastWeather.allCities();

      expect(response.getOrElse(() => throw Exception()), isA<List<City>>());

    });

    test('Dadas as cidades, retorna o erro ', () async {
      final failure = Failure(title: 'title', message: 'message');
      when(() => mockWeatherRepository.getForecast(any())).thenAnswer((_) async => Left(failure));
      final response = await getForecastWeather.allCities();

      expect(response.fold(id,id), isA<Failure>());

    });

  });

  test('Testa o filtro', () {

    var coordinates = Coordinates(lat: 1, lon: 1);

    final allCities = [
      City(cityName: 'New York', coordinates: coordinates),
      City(cityName: 'London', coordinates: coordinates),
      City(cityName: 'Paris', coordinates: coordinates),
      City(cityName: 'Berlin', coordinates: coordinates),
    ];

    final filteredCities1 = getForecastWeather.filterCities(txt: 'L', allCities: allCities);
    final filteredCities2 = getForecastWeather.filterCities(txt: 'XYZ', allCities: allCities);

    expect(filteredCities1.length, equals(2));
    expect(filteredCities2, isEmpty);
  });

}