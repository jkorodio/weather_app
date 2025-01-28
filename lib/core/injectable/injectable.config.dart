// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasource/forecastdata/forecast_datasource.dart' as _i994;
import '../../data/datasource/forecastdata/forecast_datasource_imp.dart'
    as _i549;
import '../../data/datasource/homedata/home_datasource.dart' as _i756;
import '../../data/datasource/homedata/home_datasource_imp.dart' as _i933;
import '../../data/datasource/weatherdata/weather_datasource.dart' as _i360;
import '../../data/datasource/weatherdata/weather_datasource_imp.dart' as _i253;
import '../../data/repository/forecast_repository_imp.dart' as _i192;
import '../../data/repository/home_repository_imp.dart' as _i434;
import '../../data/repository/weather_repository_imp.dart' as _i678;
import '../../domain/repository/forecast_repository.dart' as _i809;
import '../../domain/repository/home_repository.dart' as _i181;
import '../../domain/repository/weather_repository.dart' as _i798;
import '../../domain/usecase/forecast_usecases.dart' as _i787;
import '../../domain/usecase/home_usecase.dart' as _i919;
import '../../domain/usecase/weather_usecases.dart' as _i35;
import '../../pages/forecast/cubit/forecast_view_model.dart' as _i686;
import '../../pages/home/cubit/home_view_model.dart' as _i1027;
import '../../pages/weatherlist/cubit/weather_view_model.dart' as _i816;
import '../api/api_manager.dart' as _i1047;
import 'injectable.dart' as _i1027;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule(this);
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i360.WeatherDatasource>(
        () => _i253.WeatherDatasourceImp(api: gh<_i1047.ApiManager>()));
    gh.factory<_i756.HomeDatasource>(
        () => _i933.HomeDatasourceImp(apimanager: gh<_i1047.ApiManager>()));
    gh.factory<_i994.ForecastDatasource>(
        () => _i549.ForecastDatasourceImp(api: gh<_i1047.ApiManager>()));
    gh.factory<_i798.WeatherRepository>(() =>
        _i678.WeatherRepositoryImp(dataSource: gh<_i360.WeatherDatasource>()));
    gh.factory<_i809.ForecastRepository>(() => _i192.ForecastRepositoryImp(
        dataSource: gh<_i994.ForecastDatasource>()));
    gh.factory<_i35.WeatherUsecase>(
        () => _i35.WeatherUsecase(data: gh<_i798.WeatherRepository>()));
    gh.factory<_i181.HomeRepository>(
        () => _i434.HomeRepositoryImp(home: gh<_i756.HomeDatasource>()));
    gh.factory<_i919.HomeUsecase>(
        () => _i919.HomeUsecase(homeRepository: gh<_i181.HomeRepository>()));
    gh.lazySingleton<_i816.WeatherViewModel>(
        () => registerModule.weatherViewModel);
    gh.factory<_i1027.HomeViewModel>(
        () => _i1027.HomeViewModel(home: gh<_i919.HomeUsecase>()));
    gh.factory<_i787.ForecastUsecases>(
        () => _i787.ForecastUsecases(data: gh<_i809.ForecastRepository>()));
    gh.factory<_i686.ForecastViewModel>(
        () => _i686.ForecastViewModel(usecase: gh<_i787.ForecastUsecases>()));
    return this;
  }
}

class _$RegisterModule extends _i1027.RegisterModule {
  _$RegisterModule(this._getIt);

  final _i174.GetIt _getIt;

  @override
  _i816.WeatherViewModel get weatherViewModel =>
      _i816.WeatherViewModel(usecase: _getIt<_i35.WeatherUsecase>());
}
