import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routemanager/Routes.dart';
import 'package:weather_app/domain/entity/response_entity.dart';
import 'package:weather_app/pages/home/cubit/home_view_model.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.view,
    required this.temp,
    required this.unitSign,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  final ResponseEntity view;
  final double temp;
  final String unitSign;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: ListView(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Center(
                    child: Text(
                      view.location!.name ?? '',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.blue[900]!),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Image.network(
                        'https:${view.current!.condition!.icon}',
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        view.current!.condition!.text ?? '',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                isDarkMode ? Colors.white : Colors.blue[900]!),
                      ),
                      Text(
                        '${temp.toStringAsFixed(1)} $unitSign',
                        style: TextStyle(
                            color:
                                isDarkMode ? Colors.white : Colors.blue[900]!,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Max: ${unitSign == '°C' ? view.forecast!.forecastday![0].day!.maxtempC : view.forecast!.forecastday![0].day!.maxtempF} $unitSign',
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.blue[900]!,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Min: ${unitSign == '°C' ? view.forecast!.forecastday![0].day!.mintempC : view.forecast!.forecastday![0].day!.mintempF} $unitSign',
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.blue[900]!,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ]),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomItem(
                            icon: Icons.sunny,
                            text: 'Sunrise',
                            textdegre:
                                view.forecast!.forecastday![0].astro!.sunrise ??
                                    '',
                            size: 20.sp,
                            sizeicon: 50,
                            color:
                                isDarkMode ? Colors.white : Colors.blue[900]!,
                            fontWeight: FontWeight.w700,
                          ),
                          CustomItem(
                            icon: Icons.mode_night,
                            text: 'Moonrise',
                            textdegre: view.forecast!.forecastday![0].astro!
                                    .moonrise ??
                                '',
                            size: 20.sp,
                            sizeicon: 50,
                            color:
                                isDarkMode ? Colors.white : Colors.blue[900]!,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomItem(
                            icon: Icons.dew_point,
                            text: 'Humidity',
                            textdegre: '${view.current!.humidity ?? ''}',
                            size: 20.sp,
                            sizeicon: 50,
                            color:
                                isDarkMode ? Colors.white : Colors.blue[900]!,
                            fontWeight: FontWeight.w700,
                          ),
                          CustomItem(
                            icon: Icons.air,
                            text: 'Windy',
                            textdegre: '${view.current!.windKph ?? ''}',
                            size: 20.sp,
                            sizeicon: 50,
                            color:
                                isDarkMode ? Colors.white : Colors.blue[900]!,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      SizedBox(height: 25.h),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? Colors.grey[900]!
                                  : const Color.fromARGB(255, 111, 175, 247),
                            ),
                            onPressed: () {
                              final city = view.location?.name ??
                                  '${view.location?.lat},${view.location?.lon}'; // Check if city exists, else use lat/lon
                              context.push(AppRoutes.forecast,
                                  extra: {'unitSign': unitSign, 'city': city});
                            },
                            child: Text(
                              'Next 7 Days Forecast',
                              style: TextStyle(
                                  fontSize: 21.sp,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.blue[900]!),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5.h,
            left: 5.w,
            child: IconButton(
              icon: Icon(
                isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode,
                color: isDarkMode ? Colors.white : Colors.blue[900]!,
                size: 35.sp,
              ),
              onPressed: onToggleDarkMode,
            ),
          ),
          Positioned(
            top: 5.h,
            right: 5.w,
            child: IconButton(
              icon: Icon(Icons.list,
                  color: isDarkMode ? Colors.white : Colors.blue[900]!,
                  size: 35.sp),
              onPressed: () {
                final latLon = '${view.location!.lat}, ${view.location!.lon}';
                context.push(AppRoutes.weatherlist, extra: latLon.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  const CustomItem({
    super.key,
    required this.icon,
    required this.text,
    required this.textdegre,
    this.fontWeight,
    this.color,
    this.size,
    this.sizeicon,
  });

  final IconData icon;
  final double? sizeicon;
  final double? size;
  final String text;
  final String textdegre;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<HomeViewModel>().darkMode;
    return Flexible(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                  colors: isDarkMode
                      ? [
                          Color(0xff1a2344).withValues(alpha: 0.5),
                          Color(0xff1a2344).withValues(alpha: 0.2),
                        ]
                      : [
                          Color.fromARGB(255, 80, 168, 244)
                              .withValues(alpha: 0.5),
                          Color.fromARGB(255, 15, 72, 119)
                              .withValues(alpha: 0.2),
                        ]),
            ),
            child: Column(
              children: [
                Icon(icon, size: sizeicon, color: color),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: size, fontWeight: fontWeight, color: color),
                  ),
                ),
                Flexible(
                  child: Text(
                    textdegre,
                    style: TextStyle(
                        fontSize: size, fontWeight: fontWeight, color: color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
