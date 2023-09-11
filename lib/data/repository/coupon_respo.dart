import 'package:dio/dio.dart';
import 'package:lemirageelevators/data/datasource/remote/dio/dio_client.dart';
import 'package:lemirageelevators/data/datasource/remote/exception/api_error_handler.dart';
import 'package:lemirageelevators/data/model/response/base/api_response.dart';
import 'package:lemirageelevators/util/app_constants.dart';

class CouponRepo {
  final DioClient dioClient;

  CouponRepo({required this.dioClient});

  Future<ApiResponse> checkCoupon(String code) async {
    try {
      final response = await dioClient.post(
        AppConstants.CHECK_COUPON_URI,
        data: {
          'copon': code,
        },
        convertDataToFormData: true,
      );

      if (response.data is Map && response.data['status'] == true) {
        return ApiResponse.withSuccess(response);
      } else {
        return ApiResponse.withError('Invalid Coupon');
      }
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
