import 'package:cloudwalk_weather/core/errors/failure.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/city.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/weather.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/check_connectivity.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/filter_cities.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/get_forecast_weather.dart';
import 'package:cloudwalk_weather/modules/weather/presenter/bloc/forecast_weather/forecast_weather_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Replace with the actual import path

class MockGetForecastWeather extends Mock implements GetForecastWeather {}

void main() {

  CheckConnectivity connectivity = CheckConnectivityImpl();
  FilterCities mockFilterCities = FilterCitiesImpl();
  MockGetForecastWeather mockUseCase = MockGetForecastWeather();
  ForecastWeatherBloc bloc = ForecastWeatherBloc(usecase: mockUseCase, filterCities: mockFilterCities, connectivity: connectivity);

  group('ForecastWeatherBloc', () {
    
    test('emits CurrentWeatherLoading and CurrentWeatherSuccess on successful use case call', () async* {

      final coordinates = Coordinates(lat: 1, lon: 1);
      final weather = Weather(dt: DateTime.now(), temp: 1, temp_max: 1, temp_min: 1, weather_main: 'weather_main', icon: 'icon');
      final cities = [City(cityName: 'cityName', coordinates: coordinates)];
      when(() => mockUseCase.getWeather(coordinates)).thenAnswer((_) async => Right([weather]));
      when(() => mockUseCase.allCities()).thenAnswer((_) async => Right(cities));

      expectLater(
        bloc.state,
        emitsInOrder([
          ForecastWeatherLoading(),
          ForecastWeatherSuccess(cities: cities, filteredCities: cities),
        ]),
      );   

      bloc.add(GetWeatherEvent());   
    });

    test('emits CurrentWeatherLoading and CurrentWeatherError on use case failure', () async* {
      final coordinates = Coordinates(lat: 1, lon: 1);
      final failure = Failure(title: '', message: '');
      when(() => mockUseCase.getWeather(coordinates)).thenAnswer((_) async => Left(failure));
      when(() => mockUseCase.allCities()).thenAnswer((_) async =>  Left(failure));

      expectLater(
        bloc.state,
        emitsInOrder([
          ForecastWeatherLoading(),
          ForecastWeatherError(),
        ]),
      );

      bloc.add(GetWeatherEvent());
    });

    tearDown(() {
      bloc.close();
    });
  });


  test('test filter', () async* {

    var coordinates = Coordinates(lat: 1, lon: 1);

    final cities = [
      City(cityName: 'New York', coordinates: coordinates),
      City(cityName: 'London', coordinates: coordinates),
      City(cityName: 'Paris', coordinates: coordinates),
      City(cityName: 'Berlin', coordinates: coordinates),
    ];

    final filteredCities = [
      City(cityName: 'London', coordinates: coordinates),
      City(cityName: 'Berlin', coordinates: coordinates),
    ];

    final event = FilterEvent(text: 'L');
    final state = ForecastWeatherSuccess(cities: cities, filteredCities: cities);
    bloc.emit(state);

    expectLater(
        bloc.state,
        emitsInOrder([
          ForecastWeatherSuccess(cities: cities, filteredCities: filteredCities),
        ]),
      );   

    
    bloc.add(event);
  });
}
