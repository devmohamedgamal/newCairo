import 'dart:developer';
import 'package:flutter/material.dart';
import '../data/model/body/review_body.dart';
import '../data/model/response/Product/product.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/status_model.dart';
import '../data/repository/product_repo.dart';
import '../helper/api_checker.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo productRepo;
  ProductProvider({required this.productRepo});

  List<Product> allProduct = [];
  List<Product> _categoryProductList = [];
  bool _hasData = false;
  int? _imageSliderIndex = 0;
  int _rating = 0;
  int _quantity = 1;
  bool _isLoading = false;
  String? _errorText;

  String? get errorText => _errorText;
  int get quantity => _quantity;
  bool get isLoading => _isLoading;
  List<Product> get categoryProductList => _categoryProductList;
  bool get hasData => _hasData;
  int? get imageSliderIndex => _imageSliderIndex;
  int? get rating => _rating;

  // get All Product List
  Future<void> getAllProductList(BuildContext context,
      {bool reload = false}) async {
    ApiResponse apiResponse = await productRepo.getAllProductList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      allProduct.clear();
      log((apiResponse.response!.data as List).length.toString());
      for (var i = 0; i < (apiResponse.response!.data as List).length; i++) {
        allProduct
            .add(Product.fromJson((apiResponse.response!.data as List)[i]));
      }
      log(allProduct.length.toString());
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void initCategoryProductList(String id, BuildContext context) async {
    _categoryProductList = [];
    ApiResponse apiResponse = await productRepo.getCategoryProductList(id);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      if (apiResponse.response!.data != null) {
        apiResponse.response!.data.forEach(
            (product) => _categoryProductList.add(Product.fromJson(product)));
        _hasData = _categoryProductList.length > 1;
        List<Product> _products = [];
        _products.addAll(_categoryProductList);
        _categoryProductList.clear();
        _categoryProductList.addAll(_products.reversed);
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }



  Future<void> submitReview(ReviewBody reviewBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.submitReview(reviewBody);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      StatusModel statusModel;
      statusModel = StatusModel.fromJson(apiResponse.response!.data);
      callback(statusModel.status, statusModel.massage.toString());
    } else {
      callback(false, "");
    }
    _isLoading = false;
    notifyListeners();
  }

  void setQuantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  void setRating(int rate) {
    _rating = rate;
    notifyListeners();
  }

  void setErrorText(String error) {
    _errorText = error;
    notifyListeners();
  }

  void removeData() {
    _errorText = null;
    _rating = 0;
    notifyListeners();
  }

  void setImageSliderSelectedIndex(int selectedIndex) {
    _imageSliderIndex = selectedIndex;
    notifyListeners();
  }
}
