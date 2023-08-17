import 'package:dio/dio.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class WishRepo {
  final DioClient dioClient;
  WishRepo({required this.dioClient});

  Future<ApiResponse> getWishList(String clientId) async {
    try {
      final response = await dioClient.get(AppConstants.GET_WISH_URL + clientId);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addWishList(String customerID,String productID) async {
    try {
      final response = await dioClient.post(AppConstants.ADD_WISH_URL +
          customerID + "&product_id=" + productID);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeWishList(String customerID,String productID) async {
    try {
      final response = await dioClient.delete(AppConstants.ADD_WISH_URL + customerID + "&product_id=" + productID);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}