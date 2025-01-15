import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/api/api_manager.dart';
import 'package:weather_app/data/datasource/homedata/home_datasource.dart';
import 'package:weather_app/data/model/response_dto.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/fauilers.dart';

@Injectable(as: HomeDatasource)
class HomeDatasourceImp implements HomeDatasource {
  ApiManager apimanager;
  HomeDatasourceImp({required this.apimanager});
  @override
  Future<Either<Fauilers, ResponseEntity>> getWeather({String? city}) async {
    try {
      var response = await apimanager.getWeather(city: city);
      var HomeResponse = ResponseDto.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(HomeResponse);
      } else {
        return Left(ServerError(ErrorMessage: response.statusMessage!));
      }
    } catch (e) {
      return Left(NetworkError(ErrorMessage: e.toString()));
    }
  }
}
