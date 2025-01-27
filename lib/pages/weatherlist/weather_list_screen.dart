import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/pages/weatherlist/cubit/weather_view_model.dart';
import 'dart:developer';

class WeatherlistScreen extends StatefulWidget {
  const WeatherlistScreen({super.key, this.city});

  final String? city;

  @override
  WeatherlistScreenState createState() => WeatherlistScreenState();
}

class WeatherlistScreenState extends State<WeatherlistScreen> {
  int? _selectedOption;

  final TextEditingController _searchController = TextEditingController();
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().loadCities();
    _selectedOption = context.read<HomeViewModel>().unit == 'Celsius' ? 2 : 3;
  }

  void _addCity(String city) {
    if (city.isNotEmpty &&
        !context.read<WeatherCubit>().cities.contains(city)) {
      context.read<WeatherCubit>().addCity(city);
      _searchController.clear();
    } else if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid city name'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('This city is already in the list'),
      ));
    }
  }

  void _searchCity(cityName) {
    if (cityName.isNotEmpty) {
      setState(() {
        _hasSearched = true; // <-- Set to true when searching
      });
      context.read<WeatherCubit>().searchCity(cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<HomeViewModel>().darkMode;
    var cities = context.watch<WeatherCubit>().cities;
    var searchResults = context.watch<WeatherCubit>().searchResults;

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
                      String cityName = _searchController.text;
                      // context.read<WeatherCubit>().searchCity(cityName);
                      _searchCity(cityName);
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
            if (_hasSearched) ...[
              if (searchResults.isNotEmpty) ...[
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      var city = searchResults[index];
                      log(city.toString());

                      return ListTile(
                        title: Text(
                          "${city.name}, ${city.region}, ${city.country}",
                          style: TextStyle(
                              color:
                                  isDarkMode ? Colors.white : Colors.blue[900]!,
                              fontSize: 18.sp),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add, color: Colors.green),
                          onPressed: () {
                            _addCity(
                                "${city.name}, ${city.region}, ${city.country}");
                          },
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Center(
                    child: Text(
                      "No result found",
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.blue[900]!,
                          fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ],
            if (cities.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cities[index],
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.blue[900]!,
                          fontSize: 18.sp,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context
                              .read<WeatherCubit>()
                              .removeCity(cities[index]);
                        },
                      ),
                      onTap: () {
                        String city = cities[index];
                        context.push('/', extra: city);
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
