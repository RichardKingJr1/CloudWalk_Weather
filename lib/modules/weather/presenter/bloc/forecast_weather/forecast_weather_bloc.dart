import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/city.dart';
import '../../../domain/usecases/get_forecast_weather.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {

  final GetForecastWeather usecase;

  ForecastWeatherBloc({required this.usecase}) : super(ForecastWeatherInitial()) {

    on<ForecastWeatherEvent>((event, emit) async {
      emit(ForecastWeatherLoading());
      final result = await usecase.allCities();
      emit(result.fold(
        (l) => ForecastWeatherError(), 
        (r) => ForecastWeatherSuccess(r)
      ));
    });
  }

}
