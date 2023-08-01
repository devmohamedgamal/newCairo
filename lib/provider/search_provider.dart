import 'package:flutter/material.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/home_model.dart';
import '../data/repository/search_repo.dart';
import '../helper/api_checker.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo searchRepo;
  SearchProvider({required this.searchRepo});

  int _filterIndex = 0;
  List<String> _historyList = [];
  List<Product>? _searchProductList = [];
  List<Product>? _filterProductList = [];
  bool _isClear = true;
  String _searchText = '';

  int get filterIndex => _filterIndex;
  List<String> get historyList => _historyList;
  List<Product>? get searchProductList => _searchProductList;
  List<Product>? get filterProductList => _filterProductList;
  bool get isClear => _isClear;
  String get searchText => _searchText;

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }

  /// sort list
  void sortSearchList(double startingPrice, double endingPrice) {
    _searchProductList = [];
    if(startingPrice > 0 && endingPrice > startingPrice) {
      _searchProductList!.addAll(_filterProductList!.where((product) =>
      double.parse(product.price!) > startingPrice && double.parse(product.price!) < endingPrice).toList());
    }else {
      _searchProductList!.addAll(_filterProductList!);
    }

    if (_filterIndex == 0) {

    } else if (_filterIndex == 1) {
      _searchProductList!.sort((a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
    } else if (_filterIndex == 2) {
      _searchProductList!.sort((a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
      Iterable iterable = _searchProductList!.reversed;
      _searchProductList = iterable.toList().cast<Product>();
    } else if (_filterIndex == 3) {
      _searchProductList!.sort((a, b) => a.price!.compareTo(b.price!));
    } else if (_filterIndex == 4) {
      _searchProductList!.sort((a, b) => a.price!.compareTo(b.price!));
      Iterable iterable = _searchProductList!.reversed;
      _searchProductList = iterable.cast<Product>().toList();
    }

    notifyListeners();
  }

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void cleanSearchProduct() {
    _searchProductList = [];
    _isClear = true;
    _searchText = '';
    notifyListeners();
  }

  void searchProduct(String query, BuildContext context) async {
    _searchText = query;
    _isClear = false;
    _searchProductList = [];
    _filterProductList = [];
    notifyListeners();

    ApiResponse apiResponse = await searchRepo.getSearchProductList(query);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if (query.isEmpty) {
        _searchProductList = [];
      }
      else {
        print("nader ============>>>>>>>>> ${apiResponse.response!.data}");
        print("nader ============>>>>>>>>> ${apiResponse.response!.data.length}");
        _searchProductList = [];
        apiResponse.response!.data.forEach((product){
          _searchProductList!.add(Product.fromJson(product));
          _filterProductList = [];
          _filterProductList!.add(Product.fromJson(product));
        });
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void initHistoryList() {
    _historyList = [];
    _historyList.addAll(searchRepo.getSearchAddress());
    notifyListeners();
  }

  void saveSearchAddress(String searchAddress) async {
    searchRepo.saveSearchAddress(searchAddress);
    if (!_historyList.contains(searchAddress)) {
      _historyList.add(searchAddress);
    }
    notifyListeners();
  }

  void clearSearchAddress() async {
    searchRepo.clearSearchAddress();
    _historyList = [];
    notifyListeners();
  }
}