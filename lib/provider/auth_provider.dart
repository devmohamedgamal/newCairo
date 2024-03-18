import 'package:lemirageelevators/data/model/body/login_model.dart';
import 'package:lemirageelevators/data/model/body/register_model.dart';
import 'package:lemirageelevators/data/model/response/base/api_response.dart';
import 'package:lemirageelevators/data/model/response/social_login_model.dart';
import 'package:lemirageelevators/data/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import '../data/model/response/AuthModel.dart';
import '../data/model/response/status_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo});

  bool _isLoading = false;
  bool _isRemember = false;
  int _selectedIndex = 0;
  User? _user;
  String? _token;

  int get selectedIndex => _selectedIndex;
  bool get isLoading => _isLoading;
  bool get isRemember => _isRemember;
  User? get user => _user;
  String? get token => _token;

  /// registration
  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(register);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AuthModel authModel;
      authModel = AuthModel.fromJson(apiResponse.response!.data);
      callback(authModel.status, register.email, register.password,
          authModel.massage.toString());
    } else {
      callback(false, "", "", "يوجد مشكله يمكنك المحاوله في وقت لاحق");
    }
    notifyListeners();
  }

  Future about() async {
    notifyListeners();
    ApiResponse apiResponse = await authRepo.about();
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      return apiResponse.response!.data;
    } else {}
    notifyListeners();
  }

  /// login with email && password  **
  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AuthModel authModel;
      authModel = AuthModel.fromJson(apiResponse.response!.data);
      if (authModel.status!) {
        _user = authModel.userData!;
        _user!.password = loginBody.password;
        authRepo.saveUser(_user!);
      }
      callback(authModel.status, authModel.massage.toString());
    } else {
      callback(false, "يوجد مشكله يمكنك المحاوله في وقت لاحق");
    }
    notifyListeners();
  }

  /// socialLogin
  Future socialLogin(
      SocialLoginModel socialLogin, int signWith, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.socialLogin(socialLogin);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AuthModel authModel;
      authModel = AuthModel.fromJson(apiResponse.response!.data);
      if (authModel.status!) {
        _user = authModel.userData!;
        _user!.signWith = signWith;
        _user!.password = "";
        authRepo.saveUser(_user!);
      }
      callback(authModel.status, authModel.massage.toString());
    } else {
      //here
      callback(false, "يوجد مشكله يمكنك المحاوله في وقت لاحق");
    }
    notifyListeners();
  }

  /// get Token
  Future<void> getToken() async {
    _token = await authRepo.getDeviceToken();
    notifyListeners();
  }

  ///get user
  Future<void> getUser() async {
    _user = await authRepo.getUser();
    notifyListeners();
  }

  Future<void> saveUser(User use) async {
    _user = use;
    authRepo.saveUser(_user!);
    notifyListeners();
  }

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void updateRemember(bool? value) {
    _isRemember = value!;
    notifyListeners();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearUser() async {
    _user = null;
    notifyListeners();
    return await authRepo.clearUser();
  }

  /// forget Password
  Future<void> forgetPassword(String email, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.forgetPassword(email);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      StatusModel statusModel;
      statusModel = StatusModel.fromJson(apiResponse.response!.data);
      callback(statusModel.status, statusModel.massage.toString());
    } else {
      callback(false, apiResponse.error);
    }
    notifyListeners();
  }
}
