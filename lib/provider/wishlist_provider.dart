import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/wish_model.dart';
import 'package:lemirageelevators/data/repository/product_repo.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/status_model.dart';
import '../data/repository/wish_repo.dart';
import '../helper/api_checker.dart';

class WishProvider extends ChangeNotifier {
  final WishRepo wishRepo;
  final ProductRepo productRepo;
  WishProvider({
    required this.wishRepo,
    required this.productRepo
  });

  bool _wish = false;
  String _searchText = "";
  List<Wish> _wishList = [];
  List<Wish> _allWishList = [];

  bool get isWish => _wish;
  String get searchText => _searchText;
  List<Wish> get wishList => _wishList;
  List<Wish> get allWishList => _allWishList;

  clearSearchText() {
    _searchText = '';
    notifyListeners();
  }

  void searchWishList(String query) async {
    _wishList = [];
    _searchText = query;
    if (query.isNotEmpty) {
      List<Wish> products = _allWishList.where((wish) {
        return wish.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      _wishList.addAll(products);
    } else {
      _wishList.addAll(_allWishList);
    }
    notifyListeners();
  }

  void addWishList(BuildContext context,String customerID,String productID,Function callback) async {
    ApiResponse apiResponse = await wishRepo.addWishList(customerID,productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      StatusModel statusModel;
      statusModel = StatusModel.fromJson(apiResponse.response!.data);
      callback(statusModel.status,statusModel.massage,context);
      _wish = statusModel.status!;
    }
    else {
      _wish = false;
      callback(false,"",context);
    }
    notifyListeners();
  }

  void removeWishList(BuildContext context,String customerID,String productID,
      {int? index,required Function callback}) async {
    ApiResponse apiResponse = await wishRepo.addWishList(customerID,productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      StatusModel statusModel;
      statusModel = StatusModel.fromJson(apiResponse.response!.data);
      if (index != null && statusModel.status!) {
        _wishList.removeAt(index);
        _allWishList.removeAt(index);
      }
      callback(statusModel.status,statusModel.massage,context);
    }
    else {
      print('===============>>>>>>>> ${apiResponse.error.toString()}');
      callback(false,'${apiResponse.error.toString()}',context);
    }
    _wish = false;
    notifyListeners();
  }

  Future<void> initWishList(BuildContext context,String clientId) async {
    ApiResponse apiResponse = await wishRepo.getWishList(clientId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _wishList = [];
      _allWishList = [];
      WishModel wishModel;
      wishModel = WishModel.fromJson(apiResponse.response!.data);
      wishModel.wish!.forEach((wish) => _wishList.add(wish));
      wishModel.wish!.forEach((wish) => _allWishList.add(wish));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void checkWishList(String productId,String clientId, BuildContext context) async {
    ApiResponse apiResponse = await wishRepo.getWishList(clientId);
    List<String> productIdList = [];
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      WishModel wishModel;
      wishModel = WishModel.fromJson(apiResponse.response!.data);
      wishModel.wish!.forEach((wish) async {
        productIdList.add(wish.productId.toString());
      });
      productIdList.contains(productId) ? _wish = true : _wish = false;
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}