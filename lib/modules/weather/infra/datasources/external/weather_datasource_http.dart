import 'package:cloudwalk_weather/modules/weather/infra/models/weather_model.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/dependencies/http_app/httpApp.dart';
import '../weather_datasource.dart';

class WeatherDatasourceHttp implements WeatherDatasource{

  WeatherDatasourceHttp({required this.http});

  Http http;

  @override
  Future<WeatherModel> getCurrent(Coordinates coordinates) async {
    var response = await http.get("${Constants.baseUrl}weather?lat=${coordinates.lat}&lon=${coordinates.lon}&appid=${Constants.apiKey}");
    if(response.statusCode == 200) {
      return WeatherModel.fromMap(response.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<WeatherModel>> getForecast(Coordinates coordinates) async {
    var response = await http.get("${Constants.baseUrl}forecast?lat=${coordinates.lat}&lon=${coordinates.lon}&appid=${Constants.apiKey}");
    if(response.statusCode == 200) {
      return List<WeatherModel>.from((response.data['list'] as List).map<WeatherModel>((x) => WeatherModel.fromMap(x as Map<String,dynamic>)));
    } else {
      throw Exception();
    }
  }

}