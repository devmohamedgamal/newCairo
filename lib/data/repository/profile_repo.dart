// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lemirageelevators/data/model/response/user_info_model.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/address_model.dart';
import '../model/response/base/api_response.dart';

class ProfileRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({required this.dioClient,required this.sharedPreferences});

  Future<ApiResponse> getUserInfo(String clientId) async {
    try {
      final response = await dioClient.get(AppConstants.CLIENT_PROFILE_URL + clientId);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateProfile(UserInfoModel userInfoModel) async {
    try {
      final response = await dioClient.post(
        AppConstants.UPDATE_PROFILE_URI,
        data: userInfoModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  List<AddressModel> getAllAddress() {
    List<String>? addresses = sharedPreferences.getStringList(AppConstants.ADDRESSES_LIST) ?? [];
    List<AddressModel> addressList = [];
    addresses.forEach((address) => addressList.add(AddressModel.fromJson(jsonDecode(address))));
    return addressList;
  }

  void addAddress(List<AddressModel> addressList) {
    List<String> addresses = [];
    addressList.forEach((address) => addresses.add(jsonEncode(address)) );
    sharedPreferences.setStringList(AppConstants.ADDRESSES_LIST, addresses);
  }

  Future<ApiResponse> getAddressTypeList(BuildContext context) async {
    try {
      List<String> addressTypeList = [
        getTranslated("SELECT_ADDRESS_TYPE", context)!,
        getTranslated("HOME_TYPE", context)!,
        getTranslated("OFFICE_TYPE", context)!,
      ];
      Response response = Response(requestOptions: RequestOptions(path: ''), data: addressTypeList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeAddressByID(int id) async {
    try {
      final response = await dioClient.delete('${AppConstants.TO_DELIVER}$id');
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<void> saveHomeAddress(String homeAddress) async {
    try {
      await sharedPreferences.setString(AppConstants.TO_DELIVER, homeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getHomeAddress() {
    return sharedPreferences.getString(AppConstants.TO_DELIVER) ?? "";
  }

  Future<bool> clearHomeAddress() async {
    return sharedPreferences.remove(AppConstants.TO_DELIVER);
  }

  // for save office address
  Future<void> saveOfficeAddress(String officeAddress) async {
    try {
      await sharedPreferences.setString(AppConstants.TO_DELIVER, officeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getOfficeAddress() {
    return sharedPreferences.getString(AppConstants.TO_DELIVER) ?? "";
  }

  Future<bool> clearOfficeAddress() async {
    return sharedPreferences.remove(AppConstants.TO_DELIVER);
  }
}