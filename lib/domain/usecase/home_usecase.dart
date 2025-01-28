import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/repository/home_repository.dart';
import 'package:weather_app/domain/usecase/failures.dart';

@injectable
class HomeUsecase {
  HomeRepository homeRepository;
  HomeUsecase({required this.homeRepository});
  Future<Either<Failures, ResponseEntity>> invoke({String? city}) {
    return homeRepository.getWeather(city: city);
  }
}
