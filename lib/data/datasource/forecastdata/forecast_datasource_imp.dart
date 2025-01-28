import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/api/api_manager.dart';
import 'package:weather_app/data/datasource/forecastdata/forecast_datasource.dart';
import 'package:weather_app/data/model/response_dto.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/failures.dart';

@Injectable(as: ForecastDatasource)
class ForecastDatasourceImp implements ForecastDatasource {
  ApiManager api;
  ForecastDatasourceImp({required this.api});

  @override
  Future<Either<Failures, ResponseEntity>> getForecast(String city) async {
    try {
      var response = await api.getForecast(city);
      var responseForecast = ResponseDto.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(responseForecast);
      } else {
        return Left(ServerError(errorMessage: response.statusMessage!));
      }
    } catch (e) {
      return Left(NetworkError(errorMessage: e.toString()));
    }
  }
}
