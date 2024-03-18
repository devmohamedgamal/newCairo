import 'dart:developer';
import 'package:flutter/material.dart';
import '../data/model/response/Product/product.dart';
import '../data/model/response/base/api_response.dart';
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

  // get All Product List
  Future<void> getFilterProductList(BuildContext context,
      {bool reload = false, required String category}) async {
      allProduct.clear();
    ApiResponse apiResponse = await productRepo.getAllProductList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      for (var i = 0; i < (apiResponse.response!.data as List).length; i++) {
        if (apiResponse.response!.data[i]['adtype'] == category) {
          allProduct
              .add(Product.fromJson((apiResponse.response!.data as List)[i]));
        }
      }
      log(allProduct.length.toString());
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
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
