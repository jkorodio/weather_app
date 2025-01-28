import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/api/services.dart';
import 'package:weather_app/pages/home/cubit/home_state.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';
import 'package:weather_app/Pages/Home/widgets/item.dart';
import 'package:weather_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.city});
  final String? city;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final location = LocationServices();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final city = widget.city;

    if (city != null && city.isNotEmpty) {
      context.read<HomeViewModel>().getWeather(city: city);
      setState(() {
        _isLoading = false;
      });
    } else {
      final value = await location.getLocation;
      if (mounted && value != null) {
        context.read<HomeViewModel>().getWeather(
              city: '${value.latitude}, ${value.longitude}',
            );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        isDarkMode: context.watch<HomeViewModel>().darkMode,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: context.watch<HomeViewModel>().darkMode
                      ? Colors.white
                      : Colors.blue[900]!,
                ),
              )
            : BlocBuilder<HomeViewModel, HomeState>(
                builder: (context, state) {
                  if (state is HomeError) {
                    return Center(
                      child: Text(
                        'Error loading weather data',
                        style: TextStyle(fontSize: 25.sp, color: Colors.white),
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    final temperature = state.responseEntity.current!;
                    final temp = context.read<HomeViewModel>().unit == 'Celsius'
                        ? (temperature.tempC?.toDouble() ?? 0.0)
                        : (temperature.tempF?.toDouble() ?? 0.0);

                    final unitSign =
                        context.read<HomeViewModel>().unit == 'Celsius'
                            ? '°C'
                            : '°F';

                    return Item(
                      view: state.responseEntity,
                      temp: temp,
                      unitSign: unitSign,
                      isDarkMode: context.watch<HomeViewModel>().darkMode,
                      onToggleDarkMode: () {
                        final city = widget.city ??
                            '${state.responseEntity.location!.lat},${state.responseEntity.location!.lon}';
                        context
                            .read<HomeViewModel>()
                            .toggleDarkMode(city: city);
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                        color: context.watch<HomeViewModel>().darkMode
                            ? Colors.white
                            : Colors.blue[900]!),
                  );
                },
              ),
      ),
    );
  }
}
