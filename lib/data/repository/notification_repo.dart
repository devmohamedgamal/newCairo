import 'package:dio/dio.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class NotificationRepo {
  final DioClient dioClient;
  NotificationRepo({required this.dioClient});

  Future<ApiResponse> getNotificationList(String clientId) async {
    try {
      Response response = await dioClient.get(AppConstants.NOTIFICATION_URI + clientId);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}