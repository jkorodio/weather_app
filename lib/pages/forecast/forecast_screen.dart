import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/api/services.dart';
import 'package:weather_app/core/injectable/injectable.dart';
import 'package:weather_app/pages/forecast/cubit/forecast_state.dart';
import 'package:weather_app/pages/forecast/cubit/forecast_view_model.dart';
import 'package:weather_app/utils/utils.dart';

class ForecastScreen extends StatelessWidget {
  ForecastScreen({super.key, required this.unitSign});

  final String unitSign;
  final viewmodel = getIt<ForecastViewModel>();
  final location = LocationServices();

  @override
  Widget build(BuildContext context) {
    location.getLocation().then((value) => {
          if (value != null)
            {viewmodel.getForecast('${value.latitude}+${value.longitude}')}
        });

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
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w),
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
                      )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Text(
                      '7 Days Forecast',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 790.h,
              child: BlocBuilder<ForecastViewModel, ForecastState>(
                bloc: viewmodel,
                builder: (context, state) {
                  if (state is ForecastStateSuccess) {
                    return ListView.builder(
                        itemCount: viewmodel.forecast.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 125.h,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 15.h),
                            decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              leading: Image.network(
                                  'http:${viewmodel.forecast[index].day!.condition!.icon}'),
                              title: Text(
                                '${unitSign == '°C' ? viewmodel.forecast[index].day!.avgtempC : viewmodel.forecast[index].day!.avgtempF} $unitSign'
                                ' ${formatDate(viewmodel.forecast[index].date.toString())}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp),
                              ),
                              subtitle: Text(
                                'Max: ${unitSign == '°C' ? viewmodel.forecast[index].day!.maxtempC : viewmodel.forecast[index].day!.maxtempF} $unitSign'
                                ' Min: ${unitSign == '°C' ? viewmodel.forecast[index].day!.mintempC : viewmodel.forecast[index].day!.mintempF} $unitSign',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                              ),
                            ),
                          );
                        });
                  } else if (state is ForecastStateError) {
                    return Text(state.fauilers.errorMessage);
                  } else if (state is ForecastStateLoading) {
                    return Center(
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
