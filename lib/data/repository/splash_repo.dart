import 'package:dio/dio.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getAppInfo() async {
    try {
      final response = await dioClient.get(AppConstants.ABOUT_URL);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  void initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.INTRO)) {
      sharedPreferences.setBool(AppConstants.INTRO, true);
    }
  }

  void disableIntro() {
    sharedPreferences.setBool(AppConstants.INTRO, false);
  }

  bool? showIntro() {
    return sharedPreferences.getBool(AppConstants.INTRO);
  }
}