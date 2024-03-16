import 'package:lemirageelevators/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';
import '../data/model/response/about_us_model.dart';
import '../data/model/response/base/api_response.dart';
import '../helper/api_checker.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});

  bool _hasConnection = true;
  AppInfo? _appInfo;
  bool get hasConnection => _hasConnection;
  AppInfo? get appInfo => _appInfo;

  Future<bool> initAppInfo(BuildContext context) async {
    _hasConnection = true;
    ApiResponse apiResponse = await splashRepo.getAppInfo();
    bool isSuccess;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AboutUsModel aboutUsModel;
      aboutUsModel = AboutUsModel.fromJson(apiResponse.response!.data);
      _appInfo = aboutUsModel.fetchedAboutData;
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(context, apiResponse);
      if (apiResponse.error.toString() ==
          'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
    return isSuccess;
  }

  void initSharedPrefData() {
    splashRepo.initSharedData();
  }

  bool? showIntro() {
    return splashRepo.showIntro();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }
}
