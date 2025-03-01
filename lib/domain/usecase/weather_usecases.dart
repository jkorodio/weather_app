import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';
import 'package:weather_app/domain/usecase/failures.dart';

@injectable
class WeatherUsecase {
  WeatherUsecase({required this.data});
  WeatherRepository data;

  Future<Either<Failures, List<SearchEntity>>> invoke(String city) {
    return data.getCity(city);
  }
}
