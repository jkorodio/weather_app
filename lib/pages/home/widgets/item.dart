import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routemanager/Routes.dart';
import 'package:weather_app/domain/entity/response_entity.dart';

class Item extends StatelessWidget {
  Item({super.key, required this.view});
  ResponseEntity view;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Text(
            view.location!.name ?? '',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
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
              Text(
                view.current!.tempC.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  'Max: ${view.forecast!.forecastday![0].day!.maxtempC}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Min: ${view.forecast!.forecastday![0].day!.mintempC}',
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
                        view.forecast!.forecastday![0].astro!.sunrise ?? '',
                    size: 20.sp,
                    sizeicon: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomItem(
                    icon: Icons.sunny,
                    text: 'Moonrise',
                    textdegre:
                        view.forecast!.forecastday![0].astro!.moonrise ?? '',
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
                    icon: Icons.sunny,
                    text: 'Humidity',
                    textdegre: '${view.current!.humidity ?? ''}',
                    size: 20.sp,
                    sizeicon: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomItem(
                    icon: Icons.sunny,
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
                      context.push(AppRoutes.Forecast);
                    },
                    child: Text(
                      'Next 7 Days Forecast',
                      style: TextStyle(fontSize: 21.sp, color: Colors.white),
                    )),
              )
            ],
          ),
        )
      ],
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
              )),
              Flexible(
                  child: Text(
                textdegre,
                style: TextStyle(
                    fontSize: size, fontWeight: fontWeight, color: color),
              )),
            ],
          ),
        ),
      ),
    ));
  }
}
