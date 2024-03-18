import 'dart:developer';

import 'package:dio/dio.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
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
}
