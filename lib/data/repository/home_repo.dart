import 'package:dio/dio.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class HomeRepo {
  final DioClient dioClient;
  HomeRepo({required this.dioClient});

  Future<ApiResponse> getHomeData() async {
    try {
      final response = await dioClient.get(
        AppConstants.HOME_URI);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}