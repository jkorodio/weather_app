import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Core/routemanager/Routes.dart';
import 'package:weather_app/core/injectable/injectable.dart';
import 'package:weather_app/core/routemanager/route_manager.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 930),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        initialRoute: AppRoutes.Home,
        onGenerateRoute: Routemaganer.route,
      ),
    );
  }
}
