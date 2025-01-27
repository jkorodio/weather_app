import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

abstract class WeatherState {}

class WeatherStateInatial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateError extends WeatherState {
  Fauilers fauilers;
  WeatherStateError({required this.fauilers});
}

abstract class Failures {
  final String message;
  Failures(this.message);

  @override
  String toString() => message; // Ensures errors print correctly
}

class NetworkError extends Failures {
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
