import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/failures.dart';

abstract class HomeDatasource {
  Future<Either<Failures, ResponseEntity>> getWeather({String? city});
}
