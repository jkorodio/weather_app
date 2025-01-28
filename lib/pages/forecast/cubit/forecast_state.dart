import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/failures.dart';

abstract class ForecastState {}

class ForecastStateInatial extends ForecastState {}

class ForecastStateLoading extends ForecastState {}

class ForecastStateError extends ForecastState {
  Failures failures;
  ForecastStateError({required this.failures});
}

class ForecastStateSuccess extends ForecastState {
  ResponseEntity response;
  ForecastStateSuccess({required this.response});
}
