import 'package:flutter/material.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/home_model.dart';
import '../data/repository/home_repo.dart';
import '../helper/api_checker.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

  List<Sliders> _sliders = [];
  List<Product> _specialOffers = [];
  List<Category> _categories = [];
  List<Product> _products = [];
  int? _currentIndex;
  int? _categorySelectedIndex;

  List<Sliders> get sliders => _sliders;
  List<Product> get specialOffers => _specialOffers;
  List<Category> get categories => _categories;
  List<Product> get products => _products;
  int? get currentIndex => _currentIndex;
  int? get categorySelectedIndex => _categorySelectedIndex;

  Future<void> getHomeData(bool reload,BuildContext context) async {
    if (_sliders.length == 0 || reload) {
      ApiResponse apiResponse = await homeRepo.getHomeData();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _sliders = [];
        _specialOffers = [];
        _categories = [];
        _products = [];
        HomeModel homeModel;
        homeModel = HomeModel.fromJson(apiResponse.response!.data);
        _sliders = homeModel.sliders ?? [];
        _specialOffers = homeModel.specialOffers ?? [];
        _categories = homeModel.category ?? [];
        _products = homeModel.products ?? [];
        _currentIndex = 0;
        _categorySelectedIndex = 0;
      }
      else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }
}