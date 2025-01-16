import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/usecase/home_usecase.dart';
import 'package:weather_app/pages/home/cubit/home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel({required this.home}) : super(HomeInatial());
  HomeUsecase home;

  String _unit = 'Celsius'; // Default unit is Celsius

  // Getter for the unit
  String get unit => _unit;

  // Method to get the weather for the current city (if provided)
  getWeather({String? city}) async {
    emit(HomeLoading());
    var either = await home.invok(city: city);
    either.fold(
      (error) => emit(HomeError(fauilers: error)),
      (success) => emit(HomeSuccess(responseEntity: success)),
    );
  }

  // Method to update the temperature unit
  updateTemperatureUnit(String unit) {
    _unit = unit;
    emit(HomeUnitUpdated(unit: unit)); // Emit the updated unit state
    getWeather(
        city: 'current-location'); // Update weather data based on new unit
  }
}
