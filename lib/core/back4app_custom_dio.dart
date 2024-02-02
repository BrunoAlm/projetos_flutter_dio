import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCustomDio {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustomDio({required Interceptor dioInterceptor}) {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get('BACK4APP_BASE_URL');
    _dio.interceptors.add(dioInterceptor);
  }
}
