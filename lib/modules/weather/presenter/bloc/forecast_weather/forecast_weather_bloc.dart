import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/city.dart';
import '../../../domain/usecases/get_forecast_weather.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {

  final GetForecastWeather usecase;

  ForecastWeatherBloc({required this.usecase}) : super(ForecastWeatherInitial()) {

    on<GetWeatherEvent>((event, emit) async {
      emit(ForecastWeatherLoading());
      final result = await usecase.allCities();
      emit(result.fold(
        (l) => ForecastWeatherError(), 
        (r) => ForecastWeatherSuccess(cities: r, filteredCities: r)
      ));
    });

    on<FilterEvent>((event, emit) async {
      final result = usecase.filterCities(txt: event.text, allCities: (state as ForecastWeatherSuccess).cities);
      emit((state as ForecastWeatherSuccess).copyWith(filteredCities: result));
    });
  }

}
