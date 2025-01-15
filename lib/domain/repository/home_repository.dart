import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

abstract class HomeRepository {
  Future<Either<Fauilers, ResponseEntity>> getWeather({String? city});
}
