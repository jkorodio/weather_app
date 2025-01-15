import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

abstract class ForecastState {}

class ForecastStateInatial extends ForecastState {}

class ForecastStateLoading extends ForecastState {}

class ForecastStateError extends ForecastState {
  Fauilers fauilers;
  ForecastStateError({required this.fauilers});
}

class ForecastStateSuccess extends ForecastState {
  ResponseEntity response;
  ForecastStateSuccess({required this.response});
}
