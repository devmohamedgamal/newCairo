import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  final int maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("--> ${options.method} ${options.path}");
    debugPrint("Headers: ${options.headers}");
    debugPrint("parameters: ${options.queryParameters}");
    if (options.data != null) {
      debugPrint("body data: ${options.data}");
      // try{
      //   debugPrint("body data: ${json.encode(options.data)}");
      // } catch (e) {
      //   debugPrint("body data: ${options.data}");
      // }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("<-- [${response.statusCode}] ${response.requestOptions.path}");
    debugPrint("${response.data}".replaceAll('\n', ' '));
    debugPrint("-----");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("!!! API ERROR [${err.response?.statusCode}] => ${err.requestOptions.path}\n"
        "! error message: ${err.message}\n"
        "! response: ${err.response}\n"
        "!!! --------");
    return super.onError(err, handler);
  }
}
