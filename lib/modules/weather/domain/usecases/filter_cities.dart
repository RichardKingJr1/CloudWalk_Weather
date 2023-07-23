import '../entities/city.dart';

abstract class FilterCities {
  List<City> call({required String txt, required List<City> allCities});
}

class FilterCitiesImpl implements FilterCities {

  @override
  List<City> call({required String txt, required List<City> allCities}) {
    if(txt == '') return allCities;
    List<City> fileredCities = allCities.where((city) => city.cityName.toLowerCase().contains(txt.toLowerCase()) ).toList();
    return fileredCities;
  }

}