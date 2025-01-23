import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

abstract class HomeState {}

class HomeInatial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  Fauilers fauilers;
  HomeError({required this.fauilers});
}

class HomeSuccess extends HomeState {
  ResponseEntity responseEntity;
  HomeSuccess({required this.responseEntity});
}

class HomeUnitUpdated extends HomeState {
  final String unit;
  HomeUnitUpdated({required this.unit});
}

class HomeThemeUpdated extends HomeState {
  final bool isDarkMode;
  HomeThemeUpdated({required this.isDarkMode});
}
