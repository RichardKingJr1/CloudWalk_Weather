import 'package:cloudwalk_weather/core/errors/failure.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/weather.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/get_current_weather.dart';
import 'package:cloudwalk_weather/modules/weather/presenter/bloc/current_weather_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Replace with the actual import path

class MockGetCurrentWeather extends Mock implements GetCurrentWeather {}

void main() {
  group('CurrentWeatherBloc', () {
    
    MockGetCurrentWeather mockUseCase = MockGetCurrentWeather();
    CurrentWeatherBloc bloc = CurrentWeatherBloc(usecase: mockUseCase);


    test('emits CurrentWeatherLoading and CurrentWeatherSuccess on successful use case call', () async* {

      final coordinates = Coordinates(lat: 1, lon: 1);
      final weather = Weather(dt: DateTime.now(), temp: 1, temp_max: 1, temp_min: 1, weather_main: 'weather_main', icon: 'icon');
      when(() => mockUseCase.call(coordinates)).thenAnswer((_) async => Right(weather));

      expectLater(
        bloc.state,
        emitsInOrder([
          CurrentWeatherLoading(),
          CurrentWeatherSuccess(weather),
        ]),
      );   

      bloc.add(GetWeatherEvent(coordinates: coordinates));   
    });

    test('emits CurrentWeatherLoading and CurrentWeatherError on use case failure', () async* {
      final coordinates = Coordinates(lat: 1, lon: 1);
      final failure = Failure(title: '', message: '');
      when(() => mockUseCase.call(coordinates)).thenAnswer((_) async => Left(failure));

      expectLater(
        bloc.state,
        emitsInOrder([
          CurrentWeatherLoading(),
          CurrentWeatherError(),
        ]),
      );

      bloc.add(GetWeatherEvent(coordinates: coordinates));
    });

    tearDown(() {
      bloc.close();
    });
  });
}
