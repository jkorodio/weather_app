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
    // Get user's location and fetch weather data
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
            colors: [
              Color(0xff1a2344),
              Color.fromARGB(225, 130, 30, 140),
              Colors.purple,
              Color.fromARGB(225, 150, 45, 170),
            ],
          ),
        ),
        child: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            if (state is HomeError) {
              return Center(
                child: Text(
                  'Waiting Load Data',
                  style: TextStyle(fontSize: 25.sp, color: Colors.white),
                ),
              );
            } else if (state is HomeSuccess) {
              // Get the current temperature based on the selected unit
              final temperature = state.responseEntity.current!;

              // Convert the values to double using `toDouble()`
              final temp = context.read<HomeViewModel>().unit == 'Celsius'
                  ? (temperature.tempC?.toDouble() ?? 0.0) // safely handle null
                  : (temperature.tempF?.toDouble() ??
                      0.0); // safely handle null

              // Get the selected unit (Celsius or Fahrenheit)
              final unitSign =
                  context.read<HomeViewModel>().unit == 'Celsius' ? '°C' : '°F';

              // Pass the `unitSign` to the `Item` widget
              return Item(
                  view: state.responseEntity, temp: temp, unitSign: unitSign);
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
