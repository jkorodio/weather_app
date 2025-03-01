import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/api/api_manager.dart';
import 'package:weather_app/data/datasource/homedata/home_datasource.dart';
import 'package:weather_app/data/model/response_dto.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/failures.dart';

@Injectable(as: HomeDatasource)
class HomeDatasourceImp implements HomeDatasource {
  ApiManager apimanager;
  HomeDatasourceImp({required this.apimanager});
  @override
  Future<Either<Failures, ResponseEntity>> getWeather({String? city}) async {
    try {
      var response = await apimanager.getWeather(city: city);
      var homeResponse = ResponseDto.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(homeResponse);
      } else {
        return Left(ServerError(errorMessage: response.statusMessage!));
      }
    } catch (e) {
      return Left(NetworkError(errorMessage: e.toString()));
    }
  }
}
