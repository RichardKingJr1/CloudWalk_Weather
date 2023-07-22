import 'package:get_it/get_it.dart';

import 'core/dependencies/http_app/httpApp.dart';
import 'modules/weather/infra/datasources/external/weather_datasource_http.dart';
import 'modules/weather/infra/datasources/weather_datasource.dart';
import 'modules/weather/infra/repositories/weather_repository_impl.dart';
import 'modules/weather/domain/repositories/weather_repository.dart';
import 'modules/weather/domain/usecases/get_current_weather.dart';
import 'modules/weather/domain/usecases/get_forecast_weather.dart';

GetIt getIt = GetIt.instance;

void setUpProviders() {

  getIt.registerSingleton<Http>(HttpImpl());
  getIt.registerSingleton<WeatherDatasource>(WeatherDatasourceHttp(http: getIt<Http>()));
  getIt.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(weatherDatasource: getIt<WeatherDatasource>()));
  getIt.registerSingleton<GetCurrentWeather>(GetCurrentWeatherImpl(weatherRepository: getIt<WeatherRepository>()));
  getIt.registerSingleton<GetForecastWeatherImpl>(GetForecastWeatherImpl(weatherRepository: getIt<WeatherRepository>()));

}