import 'package:dio/dio.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import '../model/response/cart_model.dart';

class OrderRepo {
  final DioClient dioClient;
  OrderRepo({required this.dioClient});

  Future<ApiResponse> getOrderList(String clientId) async {
    try {
      final response = await dioClient.get(AppConstants.ORDER_URI + clientId);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> placeOrder(CartModel cartModel) async {
    try {
      final response = await dioClient.post(
          AppConstants.ORDER_PLACE_URI,
          data: cartModel.paymentMethod == 1
              ? cartModel.toJson()
              : cartModel.paymentMethod == 2
                 ? cartModel.toJsonMaster()
                 : cartModel.paymentMethod == 3 || cartModel.paymentMethod == 4 ||
                   cartModel.paymentMethod == 5
                    ? cartModel.toJsonFawry()
                    : cartModel.toJsonCashApp()
      );
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelOrder(String orderId) async {
    try {
      final response = await dioClient.get(
          AppConstants.CANCEL_ORDER_URI + orderId
      );
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}