import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/items_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../localization/language_constrants.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class CartRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  CartRepo({required this.dioClient,required this.sharedPreferences});

  List<ItemsCartModel> getCartList() {
    List<String>? carts = sharedPreferences.getStringList(AppConstants.CART_LIST) ?? [];
    List<ItemsCartModel> cartList = [];
    carts.forEach((cart) => cartList.add(ItemsCartModel.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  void addToCartList(List<ItemsCartModel> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)) );
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }

  Future<ApiResponse> getShippingPlaces() async {
    try {
      final response = await dioClient.get(AppConstants.SHIPPING_URL);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPaymentTypeList(BuildContext context) async {
    try {
      List<String> addressTypeList = [
        getTranslated("SELECT_payment_TYPE", context),
        "Google Pay",
        "Apple Pay",
        "Credit Card",
      ];
      Response response = Response(requestOptions: RequestOptions(path: ''), data: addressTypeList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSuggestedProducts(String clientId) async {
    try {
      final response = await dioClient.post(
        AppConstants.GET_SUGGESTED_PRODUCTS_URI,
        data: {
          'client_id': clientId,
        },
        convertDataToFormData: true,
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}