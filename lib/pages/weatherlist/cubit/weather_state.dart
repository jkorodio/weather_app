import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

abstract class WeatherState {}

class WeatherStateInatial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateError extends WeatherState {
  Fauilers fauilers;
  WeatherStateError({required this.fauilers});
}

class WeatherStateSuccess extends WeatherState {
  ResponseEntity response;
  WeatherStateSuccess({required this.response});
}
