import 'package:bloc/bloc.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/city.dart';
import '../../../domain/usecases/filter_cities.dart';
import '../../../domain/usecases/get_current_weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  
  final GetCurrentWeather usecase;
  final FilterCities filterCities;

  CurrentWeatherBloc({required this.filterCities, required this.usecase}) : super(CurrentWeatherInitial()) {
    
    on<GetWeatherEvent>((event, emit) async {
      emit(CurrentWeatherLoading());
      final result = await usecase.allCities();
      emit(result.fold(
        (l) => CurrentWeatherError(), 
        (r) => CurrentWeatherSuccess(cities: r, filteredCities: r)
      ));
    });

    on<FilterEvent>((event, emit) async {
      final result = filterCities(txt: event.text, allCities: (state as CurrentWeatherSuccess).cities);
      emit((state as CurrentWeatherSuccess).copyWith(filteredCities: result));
    });

  }
  
}
