import 'package:lemirageelevators/data/datasource/remote/dio/dio_client.dart';
import 'package:lemirageelevators/data/datasource/remote/exception/api_error_handler.dart';
import 'package:lemirageelevators/data/model/response/base/api_response.dart';
import 'package:lemirageelevators/data/model/response/onboarding_model.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/images.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OnBoardingRepo {
  final DioClient dioClient;
  OnBoardingRepo({required this.dioClient});

  Future<ApiResponse> getOnBoardingList(BuildContext context) async {
    try {
      List<OnboardingModel> onBoardingList = [
        OnboardingModel(
          Images.onboarding_image_one,
          '${getTranslated('on_boarding_title_one', context)} ${AppConstants.APP_NAME}',
          getTranslated('on_boarding_description_one', context)!,
        ),
        OnboardingModel(
          Images.onboarding_image_two,
          getTranslated('on_boarding_title_two', context)!,
          getTranslated('on_boarding_description_two', context)!,
        ),
        OnboardingModel(
          Images.onboarding_image_three,
          getTranslated('on_boarding_title_three', context)!,
          getTranslated('on_boarding_description_three', context)!,
        ),
      ];

      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: onBoardingList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
