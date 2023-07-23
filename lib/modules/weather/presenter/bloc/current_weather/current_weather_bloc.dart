import 'package:bloc/bloc.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/city.dart';
import '../../../domain/usecases/get_current_weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  
  final GetCurrentWeather usecase;

  CurrentWeatherBloc({required this.usecase}) : super(CurrentWeatherInitial()) {
    
    on<GetWeatherEvent>((event, emit) async {
      emit(CurrentWeatherLoading());
      final result = await usecase.allCities();
      emit(result.fold(
        (l) => CurrentWeatherError(), 
        (r) => CurrentWeatherSuccess(r)
      ));
    });

  }
}
