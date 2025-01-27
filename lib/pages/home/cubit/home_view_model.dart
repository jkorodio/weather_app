import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecase/home_usecase.dart';
import 'package:weather_app/pages/home/cubit/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final HomeUsecase home;
  String _unit = 'Celsius';
  bool _darkMode = false;
  static const String unitKey = "unit";
  static const String themeKey = "theme";

  HomeViewModel({required this.home}) : super(HomeInatial()) {
    _loadUnit();
    _loadTheme();
  }

  String get unit => _unit;
  bool get darkMode => _darkMode;

  Future<void> _loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    _unit = prefs.getString(unitKey) ?? 'Celsius';
    emit(HomeUnitUpdated(unit: _unit));
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool(themeKey) ?? true;
    emit(HomeThemeUpdated(isDarkMode: _darkMode));
  }

  Future<void> _saveUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(unitKey, unit);
  }

  Future<void> _saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkMode);
  }

  Future<void> updateTemperatureUnit(String unit,
      {required String city}) async {
    _unit = unit;
    await _saveUnit(unit);
    emit(HomeUnitUpdated(unit: unit));

    getWeather(city: city);
  }

  Future<void> toggleDarkMode({String? city}) async {
    _darkMode = !_darkMode;
    await _saveTheme(_darkMode);
    emit(HomeThemeUpdated(isDarkMode: _darkMode));
    getWeather(city: city);
  }

  getWeather({String? city}) async {
    emit(HomeLoading());
    var either = await home.invok(city: city);
    either.fold(
      (error) => emit(HomeError(fauilers: error)),
      (success) => emit(HomeSuccess(responseEntity: success)),
    );
  }
}
