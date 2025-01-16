import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/Core/routemanager/Routes.dart';
import 'package:weather_app/core/injectable/injectable.dart';
import 'package:weather_app/pages/forecast/forecast_screen.dart';
import 'package:weather_app/pages/home/home_screen.dart';
import 'package:weather_app/pages/weatherlist/weather_list_screen.dart';

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
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router, // Set up GoRouter here
        );
      },
    );
  }

  // Define GoRouter configuration
  final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.weatherlist,
        builder: (context, state) => WeatherlistScreen(),
      ),
      GoRoute(
        path: AppRoutes.forecast,
        builder: (context, state) => ForecastScreen(),
      ),
    ],
  );
}
