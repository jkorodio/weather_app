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
            colors: [
              Colors.black, // Dark start
              Colors.grey[700]!, // Dark gray
              Colors.grey[500]!, // Medium gray
              Colors.grey[300]!, // Lighter gray
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
              final temperature = state.responseEntity.current!;

              final temp = context.read<HomeViewModel>().unit == 'Celsius'
                  ? (temperature.tempC?.toDouble() ?? 0.0)
                  : (temperature.tempF?.toDouble() ?? 0.0);

              final unitSign =
                  context.read<HomeViewModel>().unit == 'Celsius' ? '°C' : '°F';

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
