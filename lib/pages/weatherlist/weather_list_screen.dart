import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherlistScreen extends StatefulWidget {
  const WeatherlistScreen({super.key, this.city});

  final String? city;

  @override
  WeatherlistScreenState createState() => WeatherlistScreenState();
}

class WeatherlistScreenState extends State<WeatherlistScreen> {
  int? _selectedOption;

  final Logger _logger = Logger();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedOption = context.read<HomeViewModel>().unit == 'Celsius' ? 2 : 3;
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

                      if (value == 3) {
                        context.read<HomeViewModel>().updateTemperatureUnit(
                            'Fahrenheit',
                            city: widget.city.toString());
                      } else if (value == 2) {
                        context.read<HomeViewModel>().updateTemperatureUnit(
                            'Celsius',
                            city: widget.city.toString());
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
                              Text("Celsius (°C)"),
                              if (_selectedOption == 2)
                                Icon(Icons.check, size: 20.sp),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 3,
                          child: Row(
                            children: [
                              Text("Fahrenheit (°F)"),
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
                        hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6)),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.2),
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
                      _logger.w("Searching for: $searchQuery");
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
