import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/api/api_manager.dart';
import 'package:weather_app/data/datasource/weatherdata/weather_datasource.dart';
import 'package:weather_app/data/model/response_dto.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

@Injectable(as: WeatherDatasource)
class WeatherDatasourceImp implements WeatherDatasource {
  ApiManager api;
  WeatherDatasourceImp({required this.api});

  @override
  Future<Either<Fauilers, List<SearchEntity>>> getCity(String? city) async {
    try {
      var response = await api.getCity(city ?? '');

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var citiesList = Search.fromJsonList(response.data);
        return Right(citiesList);
      } else {
        return Left(ServerError(errorMessage: response.statusMessage!));
      }
    } catch (e) {
      return Left(NetworkError(errorMessage: e.toString()));
    }
  }
}
