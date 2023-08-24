import 'package:lemirageelevators/data/datasource/remote/dio/dio_client.dart';
import 'package:lemirageelevators/data/datasource/remote/exception/api_error_handler.dart';
import 'package:lemirageelevators/data/model/body/payment_order_model.dart';
import 'package:lemirageelevators/data/model/response/base/api_response.dart';
import 'package:lemirageelevators/util/app_constants.dart';

class PaymentRepo {
  final DioClient dioClient;

  PaymentRepo({required this.dioClient});

  // 1st step
  Future<ApiResponse> getAuthRequest() async {
    try {
      final response = await dioClient.post(
        AppConstants.PAYMOB_AUTH_REQUEST_URI,
        data: {
          'api_key': AppConstants.PAYMOB_API_KEY,
        },
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // 2nd step
  Future<ApiResponse> registerPaymentOrder({
    required PaymentOrderModel orderModel,
    required String authToken,
  }) async {
    try {
      final response = await dioClient.post(
        AppConstants.PAYMOB_MAKE_ORDER_URI,
        data: orderModel.toJson(authToken: authToken),
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // 3rd step
  Future<ApiResponse> verifyPayment({
    required PaymentOrderModel orderModel,
    required String authToken,
    required String orderId,
    required int integrationId,
  }) async {
    try {
      final response = await dioClient.post(
        AppConstants.PAYMOB_GET_PAYMENT_TOKEN_URI,
        data: orderModel.verifyPaymentToJson(
          authToken: authToken,
          integrationId: integrationId,
          orderId: orderId,
        ),
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
