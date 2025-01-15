import 'package:flutter/material.dart';
import 'package:weather_app/Core/routemanager/routes.dart';
import 'package:weather_app/pages/forecast/forecast_screen.dart';
import 'package:weather_app/pages/home/home_screen.dart';

class Routemaganer {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.Home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.Forecast:
        return MaterialPageRoute(builder: (_) => ForecastScreen());

      default:
        return error();
    }
  }

  static Route<dynamic> error() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('Error Route'),
              ),
              body: Center(
                child: Text('Page Not Found'),
              ),
            ));
  }
}
