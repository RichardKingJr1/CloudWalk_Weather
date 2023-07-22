import 'package:get_it/get_it.dart';

import 'core/dependencies/http_app/httpApp.dart';
import 'modules/weather/data/datasources/external/weather_datasource_http.dart';
import 'modules/weather/data/datasources/weather_datasource.dart';
import 'modules/weather/data/repositories/weather_repository_impl.dart';
import 'modules/weather/domain/repositories/weather_repository.dart';
import 'modules/weather/domain/usecases/get_current_weather.dart';
import 'modules/weather/domain/usecases/get_forecast_weather.dart';

GetIt getIt = GetIt.I;

void setUpProviders() {

  getIt.registerSingleton<Http>(HttpImpl());
  getIt.registerSingleton<WeatherDatasource>(WeatherDatasourceHttp(http: getIt<HttpImpl>()));
  getIt.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(weatherDatasource: getIt<WeatherDatasourceHttp>()));
  getIt.registerSingleton<GetCurrentWeather>(GetCurrentWeatherImpl(weatherRepository: getIt<WeatherRepositoryImpl>()));
  getIt.registerSingleton<GetForecastWeatherImpl>(GetForecastWeatherImpl(weatherRepository: getIt<WeatherRepositoryImpl>()));

}