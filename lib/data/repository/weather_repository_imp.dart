import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/datasource/weatherdata/weather_datasource.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';
import 'package:weather_app/domain/usecase/failures.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImp implements WeatherRepository {
  WeatherDatasource dataSource;
  WeatherRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failures, List<SearchEntity>>> getCity(String? city) async {
    var either = await dataSource.getCity(city);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
