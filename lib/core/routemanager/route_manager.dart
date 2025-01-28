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
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final unitSign = args['unitSign'] as String? ?? '°C';
        final city = args['city'] as String? ?? '';

        return MaterialPageRoute(
          builder: (_) => ForecastScreen(unitSign: unitSign, city: city),
        );
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
