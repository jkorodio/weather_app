import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class ApiManager {
  late Dio dio;
  ApiManager() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }
  Future<Response> getWeather({Map<String, dynamic>? headers, String? city}) {
    String endpoint = city != null
        ? 'http://api.weatherapi.com/v1/forecast.json?key=ac77330cf2034093bbc52014251401&q=$city&aqi=no'
        : 'http://api.weatherapi.com/v1/forecast.json?key=ac77330cf2034093bbc52014251401&q=Muntinlupa&aqi=no';
    return dio.get(endpoint,
        options: Options(headers: headers, validateStatus: (status) => true));
  }

  Future<Response> getForecast(String city, {Map<String, dynamic>? headers}) {
    return dio.get(
        'http://api.weatherapi.com/v1/forecast.json?key=ac77330cf2034093bbc52014251401&q=$city&days=7',
        options: Options(headers: headers, validateStatus: (status) => true));
  }
}
