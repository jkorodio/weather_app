import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/domain/usecase/forecast_usecases.dart';
import 'package:weather_app/pages/forecast/cubit/forecast_state.dart';

@injectable
class ForecastViewModel extends Cubit<ForecastState> {
  ForecastViewModel({required this.usecase}) : super(ForecastStateInatial());

  ForecastUsecases usecase;
  List<ForecastEntityday> forecast = [];

  getForecast(String city) async {
    emit(ForecastStateLoading());
    var either = await usecase.invok(city);
    either.fold(
      (error) => emit(ForecastStateError(fauilers: error)),
      (success) {
        forecast = success.forecast!.forecastday ?? [];
        emit(ForecastStateSuccess(response: success));
      },
    );
  }
}
