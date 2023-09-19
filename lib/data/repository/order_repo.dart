import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> placeOrder(CartModel cartModel, dynamic PaymentMethod) async {
    try {
      final response = await dioClient.post(
        AppConstants.ORDER_PLACE_URI,
        data: cartModel.toJson(PaymentMethod),
        options: Options(
          followRedirects: false,
          maxRedirects: 0,
          validateStatus: (status) => status! < 500,
        ),
        // data: cartModel.paymentMethod == 1
          //     ? cartModel.toJsonCash()
          //     : cartModel.paymentMethod == 2
          //        ? cartModel.toJsonMasterCard(payment)
          //        : cartModel.paymentMethod == 3 || cartModel.paymentMethod == 4 ||
          //          cartModel.paymentMethod == 5
          //           ? cartModel.toJsonFawry()
          //           : cartModel.toJsonCashApp(),
      );
      String? redirectUrl;
      if(response.statusCode == 302){
        redirectUrl = '${response.headers['location']?.first}';
        debugPrint('is redirect: ${response.isRedirect}');
        log('redirect location: $redirectUrl');
        //     status: json["status"],
        //     massage: json["massage"],
        //     refId: json["ref_id"] ?? null,
        //     url: json["url"] ?? null,
        return ApiResponse.withSuccess(
          Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
            data: {
              'status': true,
              'url': redirectUrl,
            },
          ),
        );
      }
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelOrder(String orderId) async {
    try {
      final response = await dioClient.get(
          AppConstants.CANCEL_ORDER_URI + orderId
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}