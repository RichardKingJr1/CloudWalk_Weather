import 'package:cloudwalk_weather/modules/weather/data/models/weather_model.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';

abstract class WeatherDatasource {

  Future<WeatherModel> getCurrent(Coordinates coordinates);
  Future<List<WeatherModel>> getForecast(Coordinates coordinates);

}