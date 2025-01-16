import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';

class WeatherlistScreen extends StatefulWidget {
  const WeatherlistScreen({super.key});

  @override
  _WeatherlistScreenState createState() => _WeatherlistScreenState();
}

class _WeatherlistScreenState extends State<WeatherlistScreen> {
  int? _selectedOption = 2; // Default option is Celsius
  TextEditingController _searchController = TextEditingController();

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
              Color.fromARGB(225, 123, 35, 143),
              Colors.purple,
              Color.fromARGB(225, 150, 45, 170)
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 35.h, left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Weather List',
                    style: TextStyle(color: Colors.white, fontSize: 25.sp),
                  ),
                  PopupMenuButton<int>(
                    icon: Icon(
                      Icons.more_vert,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                    onSelected: (int value) {
                      setState(() {
                        _selectedOption = value;
                      });
                      // When Celsius or Fahrenheit is selected, update the unit in the HomeViewModel
                      if (value == 3) {
                        context
                            .read<HomeViewModel>()
                            .updateTemperatureUnit('Fahrenheit');
                      } else if (value == 2) {
                        context
                            .read<HomeViewModel>()
                            .updateTemperatureUnit('Celsius');
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text("Edit List"),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Row(
                            children: [
                              Text("Celsius"),
                              if (_selectedOption == 2)
                                Icon(Icons.check, size: 20.sp),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 3,
                          child: Row(
                            children: [
                              Text("Fahrenheit"),
                              if (_selectedOption == 3)
                                Icon(Icons.check, size: 20.sp),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  IconButton(
                    onPressed: () {
                      String searchQuery = _searchController.text;
                      print("Searching for: $searchQuery");
                    },
                    icon: Icon(
                      Icons.search,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
