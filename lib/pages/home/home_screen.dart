import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Pages/Home/Widgets/item.dart';
import 'package:weather_app/core/api/services.dart';
import 'package:weather_app/core/injectable/injectable.dart';
import 'package:weather_app/pages/home/cubit/home_state.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var viewmodel = getIt<HomeViewModel>();
  var location = LocationServices();
  @override
  Widget build(BuildContext context) {
    location.getLocation().then((value) {
      if (value != null) {
        viewmodel.getWeather(city: '${value.latitude}, ${value.longitude}');
      }
    });
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
              ])),
          child: BlocBuilder(
              bloc: viewmodel,
              builder: (context, state) {
                if (state is HomeError) {
                  return Center(
                    child: Text(
                      'Waiting Load Data',
                      style: TextStyle(fontSize: 25.sp, color: Colors.white),
                    ),
                  );
                } else if (state is HomeSuccess) {
                  return Item(view: state.responseEntity);
                }
                return Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              })),
    );
  }
}
