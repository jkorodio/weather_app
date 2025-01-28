import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/repository/forecast_repository.dart';
import 'package:weather_app/domain/usecase/failures.dart';

@injectable
class ForecastUsecases {
  ForecastUsecases({required this.data});
  ForecastRepository data;
  Future<Either<Failures, ResponseEntity>> invoke(String city) {
    return data.getForecast(city);
  }
}
