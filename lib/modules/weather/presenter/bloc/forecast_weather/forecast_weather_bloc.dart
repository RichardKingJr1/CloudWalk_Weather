import 'package:bloc/bloc.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/filter_cities.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/city.dart';
import '../../../domain/usecases/check_connectivity.dart';
import '../../../domain/usecases/get_forecast_weather.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {

  final GetForecastWeather usecase;
  final FilterCities filterCities;
  final CheckConnectivity connectivity;

  ForecastWeatherBloc({required this.connectivity,  required this.filterCities, required this.usecase}) : super(ForecastWeatherInitial()) {

    on<GetWeatherEvent>((event, emit) async {
      emit(ForecastWeatherLoading());

      if(await connectivity()) {
        emit(ForecastWeatherConnection());
        return;
      }

      final result = await usecase.allCities();
      emit(result.fold(
        (l) => ForecastWeatherError(), 
        (r) => ForecastWeatherSuccess(cities: r, filteredCities: r)
      ));
    });

    on<FilterEvent>((event, emit) async {
      final result = filterCities(txt: event.text, allCities: (state as ForecastWeatherSuccess).cities);
      emit((state as ForecastWeatherSuccess).copyWith(filteredCities: result));
    });
  }

}
