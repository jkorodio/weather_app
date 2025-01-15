import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/datasource/forecastdata/forecast_datasource.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/repository/forecast_repository.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

@Injectable(as: ForecastRepository)
class ForecastRepositoryImp implements ForecastRepository {
  ForecastDatasource dataSource;
  ForecastRepositoryImp({required this.dataSource});
  @override
  Future<Either<Fauilers, ResponseEntity>> getForecast(String city) async {
    var either = await dataSource.getForecast(city);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
