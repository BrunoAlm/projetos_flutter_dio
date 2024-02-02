import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCepDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["X-Parse-Application-Id"] =
        dotenv.get('BACK4APP_CEP_APPLICATION_ID');
    options.headers["X-Parse-REST-API-Key"] =
        dotenv.get('BACK4APP_CEP_REST_API_KEY');

    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }
}
