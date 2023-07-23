import 'package:cloudwalk_weather/modules/weather/domain/entities/city.dart';
import 'package:cloudwalk_weather/modules/weather/domain/entities/coodinates.dart';
import 'package:cloudwalk_weather/modules/weather/domain/usecases/filter_cities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  final filterCities = FilterCitiesImpl();

  test('Testa o filtro', () {

    var coordinates = Coordinates(lat: 1, lon: 1);

    final allCities = [
      City(cityName: 'New York', coordinates: coordinates),
      City(cityName: 'London', coordinates: coordinates),
      City(cityName: 'Paris', coordinates: coordinates),
      City(cityName: 'Berlin', coordinates: coordinates),
    ];

    final filteredCities1 = filterCities(txt: 'L', allCities: allCities);
    final filteredCities2 = filterCities(txt: 'XYZ', allCities: allCities);

    expect(filteredCities1.length, equals(2));
    expect(filteredCities2, isEmpty);
  });
}