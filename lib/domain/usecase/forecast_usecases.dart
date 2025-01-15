import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/repository/forecast_repository.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

@injectable
class ForecastUsecases {
  ForecastUsecases({required this.data});
  ForecastRepository data;
  Future<Either<Fauilers, ResponseEntity>> invok(String city) {
    return data.getForecast(city);
  }
}
