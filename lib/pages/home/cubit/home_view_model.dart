import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecase/home_usecase.dart';
import 'package:weather_app/pages/home/cubit/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final HomeUsecase home;
  String _unit = 'Celsius';
  static const String unitKey = "unit";

  HomeViewModel({required this.home}) : super(HomeInatial()) {
    _loadUnit();
  }

  String get unit => _unit;

  Future<void> _loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    _unit = prefs.getString(unitKey) ?? 'Celsius';
    emit(HomeUnitUpdated(unit: _unit));
  }

  Future<void> _saveUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(unitKey, unit);
  }

  getWeather({String? city}) async {
    emit(HomeLoading());
    var either = await home.invok(city: city);
    either.fold(
      (error) => emit(HomeError(fauilers: error)),
      (success) => emit(HomeSuccess(responseEntity: success)),
    );
  }

  Future<void> updateTemperatureUnit(String unit,
      {required String city}) async {
    _unit = unit;
    await _saveUnit(unit);
    emit(HomeUnitUpdated(unit: unit));

    getWeather(city: city);
  }
}
