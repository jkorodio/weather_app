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
    final isDarkMode = context.read<HomeViewModel>().darkMode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
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
                      color: isDarkMode ? Colors.white : Colors.blue[900]!,
                    ),
                  ),
                  Text(
                    'Weather List',
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.blue[900]!,
                        fontSize: 25.sp),
                  ),
                  PopupMenuButton<int>(
                    icon: Icon(
                      Icons.more_vert,
                      size: 30.sp,
                      color: isDarkMode ? Colors.white : Colors.blue[900]!,
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
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.6)
                                : Colors.blue[900]!),
                        filled: true,
                        fillColor: isDarkMode
                            ? Colors.white.withValues(alpha: 0.6)
                            : const Color.fromARGB(255, 112, 180, 236)
                                .withValues(alpha: 0.6),
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
                      color: isDarkMode ? Colors.white : Colors.blue[900]!,
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
