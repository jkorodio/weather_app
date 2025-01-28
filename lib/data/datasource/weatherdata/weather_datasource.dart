import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/failures.dart';

abstract class WeatherDatasource {
  Future<Either<Failures, List<SearchEntity>>> getCity(String? city);
}
