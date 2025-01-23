import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/api/services.dart';
import 'package:weather_app/pages/home/cubit/home_state.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';
import 'package:weather_app/Pages/Home/widgets/item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final location = LocationServices();

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final value = await location.getLocation();
    if (mounted && value != null) {
      context.read<HomeViewModel>().getWeather(
            city: '${value.latitude}, ${value.longitude}',
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: context.watch<HomeViewModel>().darkMode
                ? [
                    Colors.black,
                    Colors.grey[900]!,
                    Colors.grey[700]!,
                    Colors.grey[500]!,
                  ]
                : [
                    Colors.blue[100]!,
                    Colors.blue[300]!,
                    Colors.blue[500]!,
                    Colors.blue[700]!,
                  ],
          ),
        ),
        child: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            final isDarkMode = context.read<HomeViewModel>().darkMode;

            if (state is HomeError) {
              return Center(
                child: Text(
                  'Waiting Load Data',
                  style: TextStyle(fontSize: 25.sp, color: Colors.white),
                ),
              );
            } else if (state is HomeSuccess) {
              final temperature = state.responseEntity.current!;

              final temp = context.read<HomeViewModel>().unit == 'Celsius'
                  ? (temperature.tempC?.toDouble() ?? 0.0)
                  : (temperature.tempF?.toDouble() ?? 0.0);

              final unitSign =
                  context.read<HomeViewModel>().unit == 'Celsius' ? '°C' : '°F';

              return Item(
                view: state.responseEntity,
                temp: temp,
                unitSign: unitSign,
                isDarkMode: isDarkMode, // Pass dark mode state
                onToggleDarkMode: () {
                  final location =
                      '${state.responseEntity.location!.lat},${state.responseEntity.location!.lon}';
                  context
                      .read<HomeViewModel>()
                      .toggleDarkMode(city: location.toString());
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                  color: isDarkMode ? Colors.white : Colors.blue[900]!),
            );
          },
        ),
      ),
    );
  }
}
