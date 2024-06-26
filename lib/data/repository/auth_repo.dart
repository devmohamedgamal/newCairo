// ignore_for_file: use_rethrow_when_possible, unnecessary_null_in_if_null_operators, await_only_futures, avoid_function_literals_in_foreach_calls
import 'dart:convert';
import 'package:newcairo/data/datasource/remote/dio/dio_client.dart';
import 'package:newcairo/data/datasource/remote/exception/api_error_handler.dart';
import 'package:newcairo/data/model/body/login_model.dart';
import 'package:newcairo/data/model/body/register_model.dart';
import 'package:newcairo/data/model/response/AuthModel.dart';
import 'package:newcairo/data/model/response/base/api_response.dart';
import 'package:newcairo/util/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});

  ///registration
  Future<ApiResponse> registration(RegisterModel register) async {
    try {
      Response response = await dioClient.post(
        AppConstants.REGISTRATION_URI,
        data: register.toJson(),
        convertDataToFormData: true,
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///about
  Future<ApiResponse> about() async {
    try {
      Response response = await dioClient.get(AppConstants.getAbout);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: loginBody.toJsonApi(),
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// get Device Token
  Future<String> getDeviceToken() async {
    String? _deviceToken;
    _deviceToken = await FirebaseMessaging.instance.getToken();

    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken!;
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.USER);
  }

  Future<bool> clearUser() async {
    return await sharedPreferences.remove(AppConstants.USER);
  }

  Future<void> saveUser(User user) async {
    try {
      await sharedPreferences.setString(AppConstants.USER, jsonEncode(user));
    } catch (e) {
      throw e;
    }
  }

  Future<User?> getUser() async {
    String? user = await sharedPreferences.getString(AppConstants.USER) ?? null;
    return user == null ? null : User.fromJson(jsonDecode(user));
  }

  /// forget Password
  Future<ApiResponse> forgetPassword(String email) async {
    try {
      Response response = await dioClient.post(AppConstants.FORGET_PASSWORD_URI,
          data: FormData.fromMap({
            "email": email,
          }));
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
