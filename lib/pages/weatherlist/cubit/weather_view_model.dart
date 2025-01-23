import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnitEvent { changeToCelsius, changeToFahrenheit }

class TemperatureUnitState {
  final bool isCelsius;
  TemperatureUnitState({required this.isCelsius});
}

class WeatherCubit extends Cubit<TemperatureUnitState> {
  WeatherCubit() : super(TemperatureUnitState(isCelsius: true));

  List<String> _cities = [];
  List<String> get cities => _cities;

  Future<void> loadCities() async {
    final prefs = await SharedPreferences.getInstance();
    _cities = prefs.getStringList('cityList') ?? [];
    emit(TemperatureUnitState(isCelsius: state.isCelsius));
  }

  Future<void> saveCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cityList', _cities);
  }

  void addCity(String city) {
    if (!_cities.contains(city)) {
      _cities.add(city);
      saveCities(); // Save after adding the city
      emit(TemperatureUnitState(isCelsius: state.isCelsius));
    }
  }

  void removeCity(String city) {
    _cities.remove(city);
    saveCities(); // Save after removing the city
    emit(
        TemperatureUnitState(isCelsius: state.isCelsius)); // Trigger the update
  }

  void changeTemperatureUnit(TemperatureUnitEvent event) {
    if (event == TemperatureUnitEvent.changeToCelsius) {
      emit(TemperatureUnitState(isCelsius: true));
    } else {
      emit(TemperatureUnitState(isCelsius: false));
    }
  }
}
