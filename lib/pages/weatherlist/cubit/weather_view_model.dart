import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/weather_usecases.dart';
import 'package:weather_app/pages/weatherlist/cubit/weather_state.dart';

enum TemperatureUnitEvent { changeToCelsius, changeToFahrenheit }

class WeatherViewModel extends Cubit<WeatherState> {
  WeatherViewModel({required this.usecase})
      : super(WeatherStateTempUnit(isCelsius: true));

  WeatherUsecase usecase;
  List<String> _cities = [];
  List<SearchEntity> searchResults = [];

  List<String> get cities => _cities;

  Future<void> loadCities() async {
    final prefs = await SharedPreferences.getInstance();
    _cities = prefs.getStringList('cityList') ?? [];
    if (state is WeatherStateTempUnit) {
      emit(WeatherStateTempUnit(
          isCelsius: (state as WeatherStateTempUnit).isCelsius));
    } else {
      // Handle other cases, or do nothing if you don't need to handle them here
      // For example:
      // emit(WeatherStateTempUnit(isCelsius: t rue)); // default state
    }
  }

  Future<void> saveCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cityList', _cities);
  }

  Future<void> searchCity(String city) async {
    final result = await usecase.invoke(city);
    // log("❌ Network Error: ${result.toString()}");
    result.fold(
      (error) {
        emit(WeatherStateError(failures: error));
      },
      (success) {
        // log(success.toString());
        List<SearchEntity> searchResultsList = success;
        searchResults = searchResultsList;
        emit(SearchSuccess(response: searchResults));
      },
    );
  }

  void addCity(String city) {
    if (!_cities.contains(city)) {
      _cities.add(city);
      saveCities();
      emit(CitiesUpdated(cities: _cities));
    }
  }

  void removeCity(String city) {
    _cities.remove(city);
    saveCities();
    emit(CitiesUpdated(cities: _cities));
  }

  void changeTemperatureUnit(TemperatureUnitEvent event) {
    if (event == TemperatureUnitEvent.changeToCelsius) {
      emit(WeatherStateTempUnit(isCelsius: true));
    } else {
      emit(WeatherStateTempUnit(isCelsius: false));
    }
  }
}
