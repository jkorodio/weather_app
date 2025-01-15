import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/usecase/home_usecase.dart';
import 'package:weather_app/pages/home/cubit/home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel({required this.home}) : super(HomeInatial());
  HomeUsecase home;

  getWeather({String? city}) async {
    emit(HomeLoading());
    var either = await home.invok(city: city);
    either.fold((error) => emit(HomeError(fauilers: error)),
        (success) => emit(HomeSuccess(responseEntity: success)));
  }
}
