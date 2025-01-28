import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/datasource/homedata/home_datasource.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/repository/home_repository.dart';
import 'package:weather_app/domain/usecase/failures.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImp implements HomeRepository {
  HomeDatasource home;
  HomeRepositoryImp({required this.home});
  @override
  Future<Either<Failures, ResponseEntity>> getWeather({String? city}) async {
    var either = await home.getWeather(city: city);
    return either.fold(
        (error) => Left(error),
        (
          response,
        ) =>
            Right(response));
  }
}
