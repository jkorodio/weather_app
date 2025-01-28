import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/Core/routemanager/Routes.dart';
import 'package:weather_app/core/injectable/injectable.dart';
import 'package:weather_app/pages/forecast/forecast_screen.dart';
import 'package:weather_app/pages/home/home_screen.dart';
import 'package:weather_app/pages/weatherlist/weather_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';
import 'package:weather_app/pages/weatherlist/cubit/weather_view_model.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 930),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HomeViewModel>(
              create: (context) => getIt<HomeViewModel>(),
            ),
            BlocProvider<WeatherViewModel>(
              create: (context) => getIt<WeatherViewModel>(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
          ),
        );
      },
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          final city = state.extra as String?;
          return HomeScreen(city: city);
        },
      ),
      GoRoute(
        path: AppRoutes.weatherlist,
        builder: (context, state) {
          final city = state.extra as String?;
          return WeatherlistScreen(city: city);
        },
      ),
      GoRoute(
        path: AppRoutes.forecast,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final unitSign = extra['unitSign'] as String? ?? '°C';
          final city = extra['city'] as String? ?? '';

          return ForecastScreen(unitSign: unitSign, city: city);
        },
      ),
    ],
  );
}
