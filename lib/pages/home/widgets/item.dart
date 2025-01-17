import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routemanager/Routes.dart';
import 'package:weather_app/domain/entity/response_entity.dart';

class Item extends StatelessWidget {
  const Item(
      {super.key,
      required this.view,
      required this.temp,
      required this.unitSign});

  final ResponseEntity view;
  final double temp;
  final String unitSign; // New parameter for unit sign

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
                colors: [
                  Color(0xff1a2344),
                  Color.fromARGB(225, 130, 30, 140),
                  Colors.purple,
                  Color.fromARGB(225, 150, 45, 170),
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
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
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
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      // Display temperature with the unit sign (°C or °F)
                      Text(
                        '${temp.toStringAsFixed(1)} $unitSign', // Adding the unit sign here
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Max: ${unitSign == '°C' ? view.forecast!.forecastday![0].day!.maxtempC : view.forecast!.forecastday![0].day!.maxtempF} $unitSign',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Min: ${unitSign == '°C' ? view.forecast!.forecastday![0].day!.mintempC : view.forecast!.forecastday![0].day!.mintempF} $unitSign',
                              style: TextStyle(
                                  color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          CustomItem(
                            icon: Icons.air,
                            text: 'Windy',
                            textdegre: '${view.current!.windKph ?? ''}',
                            size: 20.sp,
                            sizeicon: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      SizedBox(height: 25.h),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff1a2344)),
                            onPressed: () {
                              context.push(AppRoutes.forecast, extra: unitSign);
                            },
                            child: Text(
                              'Next 7 Days Forecast',
                              style: TextStyle(
                                  fontSize: 21.sp, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5.h,
            right: 5.w,
            child: IconButton(
              icon: Icon(Icons.list, color: Colors.white, size: 35.sp),
              onPressed: () {
                context.push(AppRoutes.weatherlist,
                    extra: view.location!.name ?? '');
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
              gradient: LinearGradient(colors: [
                Color(0xff1a2344).withValues(alpha: 0.5),
                Color(0xff1a2344).withValues(alpha: 0.2),
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
