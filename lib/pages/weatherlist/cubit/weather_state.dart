import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/failures.dart';

abstract class WeatherState {}

class WeatherStateInatial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateError extends WeatherState {
  Failures failures;
  WeatherStateError({required this.failures});
}

abstract class FailuresE {
  final String message;
  FailuresE(this.message);

  @override
  String toString() => message;
}

class NetworkError extends FailuresE {
  NetworkError(super.message);
}

class WeatherStateSuccess extends WeatherState {
  ResponseEntity response;
  WeatherStateSuccess({required this.response});
}

class SearchSuccess extends WeatherState {
  List<SearchEntity> response;
  SearchSuccess({required this.response});
}

class WeatherStateTempUnit extends WeatherState {
  final bool isCelsius;
  WeatherStateTempUnit({required this.isCelsius});
}

class CitiesUpdated extends WeatherState {
  final List<String> cities;
  CitiesUpdated({required this.cities});
}
