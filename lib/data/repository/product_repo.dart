import 'dart:developer';

import 'package:dio/dio.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/review_body.dart';
import '../model/response/base/api_response.dart';

class ProductRepo {
  final DioClient dioClient;
  ProductRepo({required this.dioClient});

  //get all Products
  Future<ApiResponse> getAllProductList() async {
    try {
      final response = await dioClient.get(AppConstants.GET_PRODUCT_URL);
      log(response.data.toString());
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryProductList(String id) async {
    try {
      final response =
          await dioClient.get(AppConstants.CATEGORY_PRODUCT_URI + id);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDetailsProduct(
      String productID, String customerID) async {
    try {
      final response = await dioClient.post(
        AppConstants.PRODUCT_DETAILS_URL,
        data: {
          'product_id': productID,
          'customer_id': customerID,
        },
        convertDataToFormData: true,
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> submitReview(ReviewBody reviewBody) async {
    try {
      final response = await dioClient.post(
        AppConstants.RATING_URL,
        data: reviewBody.toJsonApi(),
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
