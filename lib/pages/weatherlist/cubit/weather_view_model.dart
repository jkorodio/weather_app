import 'package:flutter_bloc/flutter_bloc.dart';

enum TemperatureUnitEvent { changeToCelsius, changeToFahrenheit }

class TemperatureUnitState {
  final bool isCelsius;
  TemperatureUnitState({required this.isCelsius});
}

class WeatherCubit extends Cubit<TemperatureUnitState> {
  WeatherCubit() : super(TemperatureUnitState(isCelsius: true));

  void changeTemperatureUnit(TemperatureUnitEvent event) {
    if (event == TemperatureUnitEvent.changeToCelsius) {
      emit(TemperatureUnitState(isCelsius: true));
    } else {
      emit(TemperatureUnitState(isCelsius: false));
    }
  }
}
