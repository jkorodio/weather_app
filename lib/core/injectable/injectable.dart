// injectable.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/pages/weatherlist/cubit/weather_view_model.dart';

import 'injectable.config.dart'; // Ensure this file is generated

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  WeatherCubit get weatherCubit;
}
