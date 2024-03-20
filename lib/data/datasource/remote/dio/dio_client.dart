// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison, prefer_const_constructors, use_rethrow_when_possible
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:newcairo/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final String? baseUrl;
  final LoggingInterceptor? loggingInterceptor;
  final SharedPreferences? sharedPreferences;
  Dio? dio;
  String? token;
  String? key;

  DioClient(this.baseUrl, Dio dioC,
      {this.loggingInterceptor, this.sharedPreferences}) {
    dio = dioC;

    dio!
      ..options.baseUrl = baseUrl!
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..httpClientAdapter
      ..options.followRedirects = false
      ..options.headers.addAll({
        'Accept': 'application/json',
        'content-type': 'application/json',
      });

    if (loggingInterceptor != null) {
      dio!.interceptors.add(loggingInterceptor!);
    }
  }

  // void updateHeaderWithKeyLink(String? key,String? link) {
  //   dio!..options.baseUrl = link!
  //     ..options.headers = {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //   };
  // }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> post(
    String uri, {
    dynamic data,
    bool convertDataToFormData = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio!.post(
        uri,
        data: convertDataToFormData && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio!.delete(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> head(
    String uri, {
    dynamic data,
    bool convertDataToFormData = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio!.head(
        uri,
        data: convertDataToFormData && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
