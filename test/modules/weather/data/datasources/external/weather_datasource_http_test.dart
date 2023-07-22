import 'package:cloudwalk_weather/core/dependencies/http_app/httpApp.dart';
import 'package:cloudwalk_weather/modules/weather/infra/datasources/external/weather_datasource_http.dart';
import 'package:cloudwalk_weather/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:cloudwalk_weather/modules/weather/infra/models/weather_model.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_request.dart';

class HttpMock extends  Mock implements Http {}

void main() {
  
  group('datasource', () { 

    Http httpMock = HttpMock();
    WeatherDatasource weatherDatasource = WeatherDatasourceHttp(http: httpMock);

    test('Feita a busca, deve retornar WeatherModel', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      when(() => httpMock.get(any())).thenAnswer((_) async => Response(requestOptions: RequestOptions(), statusCode: 200, data: mockCurrent));

      final response = await weatherDatasource.getCurrent(coordinates);

      expect(response, isA<WeatherModel>());
    });

    test('Feita a busca, deve retornar List<WeatherModel>', () async {

      Coordinates coordinates = Coordinates(lat: 1, lon: 1);
      when(() => httpMock.get(any())).thenAnswer((_) async => Response(requestOptions: RequestOptions(), statusCode: 200, data: mockForecast));

      final response = await weatherDatasource.getForecast(coordinates);

      expect(response, isA<List<WeatherModel>>());
    });

  });


  

}