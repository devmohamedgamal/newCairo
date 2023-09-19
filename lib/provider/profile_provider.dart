import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/client_profile_model.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import '../data/model/body/address_model.dart';
import '../data/model/response/AuthModel.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/status_model.dart';
import '../data/model/response/user_info_model.dart';
import '../data/repository/profile_repo.dart';
import '../helper/api_checker.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({required this.profileRepo});

  List<String> _addressTypeList = [];
  String _addressType = '';
  bool _isLoading = false;
  List<AddressModel> _addressList = [];
  User? _user;
  int? _addressIndex;
  ClientProfileModel? _clientProfileModel;
  bool? _hasData;
  bool _isHomeAddress = true;
  bool _checkOfficeAddress = false;
  bool _checkHomeAddress = false;
  String? _addAddressErrorText;

  int? get addressIndex => _addressIndex;
  List<String> get addressTypeList => _addressTypeList;
  String get addressType => _addressType;
  bool get isLoading => _isLoading;
  List<AddressModel> get addressList => _addressList;
  User? get user => _user;
  ClientProfileModel? get clientProfileModel => _clientProfileModel;
  bool? get hasData => _hasData;
  bool get isHomeAddress => _isHomeAddress;
  String? get addAddressErrorText => _addAddressErrorText;
  bool get checkHomeAddress=>_checkHomeAddress;
  bool get checkOfficeAddress=>_checkOfficeAddress;
  AddressModel? get getSelectedAddress => (_addressList.isNotEmpty && _addressIndex != null) ? _addressList[_addressIndex!] : null;

  Future<void> getUserInfo(BuildContext context,String clientId) async {
    ApiResponse apiResponse = await profileRepo.getUserInfo(clientId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _clientProfileModel = ClientProfileModel.fromJson(apiResponse.response!.data);
    }
    else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void getAddress() {
    _addressList = [];
    _addressList.addAll(profileRepo.getAllAddress());
  }

  void addAddress(BuildContext context,AddressModel addressModel,Function callback) {
    try{
      _addressList.add(addressModel);
      profileRepo.addAddress(_addressList);
      callback(getTranslated("address_add", context));
      notifyListeners();
    }
    catch(e){
      callback(getTranslated("address_error", context));
    }
  }

  void removeAddress(int index) {
    _addressList.removeAt(index);
    profileRepo.addAddress(_addressList);
    notifyListeners();
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    notifyListeners();
  }

  void setAddAddressErrorText(String? errorText,bool init) {
    _addAddressErrorText = errorText;
    if(init) {
      notifyListeners();
    }
  }

  void updateAddressCondition(bool value) {
    _isHomeAddress = value;
    notifyListeners();
  }

  void setHomeAddress() {
    _checkHomeAddress = true;
    _checkOfficeAddress = false;
    notifyListeners();
  }

  void setOfficeAddress() {
    _checkHomeAddress = false;
    _checkOfficeAddress = true;
    notifyListeners();
  }

  updateAddressType(String? value) {
    _addressType = value!;
    notifyListeners();
  }

  void initAddressTypeList(BuildContext context) async {
    if (_addressTypeList.length == 0) {
      ApiResponse apiResponse = await profileRepo.getAddressTypeList(context);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _addressTypeList.clear();
        _addressTypeList.addAll(apiResponse.response!.data);
        _addressType = apiResponse.response!.data[0];
      }
      else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  Future<void> updateUserInfo(UserInfoModel updateUserModel,BuildContext context,Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await profileRepo.updateProfile(updateUserModel);
    _isLoading = false;
    if (apiResponse.response != null) {
      StatusModel statusModel;
      statusModel = StatusModel.fromJson(apiResponse.response!.data);
      callback(statusModel.status,statusModel.massage);
    }
    else {
      callback(false,"error");
    }
    notifyListeners();
  }

  void saveHomeAddress(String homeAddress) {
    profileRepo.saveHomeAddress(homeAddress).then((_) {
      notifyListeners();
    });
  }

  void saveOfficeAddress(String officeAddress) {
    profileRepo.saveOfficeAddress(officeAddress).then((_) {
      notifyListeners();
    });
  }

  // for home Address Section
  String getHomeAddress() {
    return profileRepo.getHomeAddress();
  }

  Future<bool> clearHomeAddress() async {
    return await profileRepo.clearHomeAddress();
  }

  // for office Address Section
  String getOfficeAddress() {
    return profileRepo.getOfficeAddress();
  }

  Future<bool> clearOfficeAddress() async {
    return await profileRepo.clearOfficeAddress();
  }
}