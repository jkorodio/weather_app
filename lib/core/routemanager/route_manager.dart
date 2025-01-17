// routemanager.dart
import 'package:flutter/material.dart';
import 'package:weather_app/Core/routemanager/routes.dart';
import 'package:weather_app/pages/forecast/forecast_screen.dart';
import 'package:weather_app/pages/home/home_screen.dart';
import 'package:weather_app/pages/weatherlist/weather_list_screen.dart';

class Routemanager {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.weatherlist:
        return MaterialPageRoute(builder: (_) => WeatherlistScreen());
      case AppRoutes.forecast:
        // Retrieve unitSign from settings.arguments
        final unitSign =
            settings.arguments as String? ?? '°C'; // Default to Celsius
        return MaterialPageRoute(
            builder: (_) => ForecastScreen(unitSign: unitSign));
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
