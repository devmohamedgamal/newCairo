import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/area_model.dart';
import 'package:lemirageelevators/data/model/response/city_model.dart';
import 'package:lemirageelevators/data/model/response/home_model.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/items_cart_model.dart';
import '../data/model/response/governorate_model.dart';
import '../data/repository/cart_repo.dart';
import '../helper/api_checker.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({required this.cartRepo});

  List<String> _paymentTypeList = [];
  List<ItemsCartModel> _cartList = [];
  List<GovernorateModel> _shippingPlacesList = [];
  int? _shippingPlacesIndex;
  List<ShippingCityModel> _shippingCitiesList = [];
  int? _shippingCitiesIndex;
  bool _isLoadingCities = false;
  List<ShippingAreaModel> _shippingAreasList = [];
  int? _shippingAreasIndex;
  bool _isLoadingAreas = false;
  String _paymentType = '';
  int? _indexType;
  int? _paymentIndex = 0;
  double _amount = 0.0;
  // double _discount = 0.0;
  bool _isLoading = false;
  bool _isLoadingSuggestions = false;
  List<Product> _suggestedProducts = [];
  double _shippingPrice = 0;

  List<String> get paymentTypeList => _paymentTypeList;
  List<ItemsCartModel> get cartList => _cartList;
  List<GovernorateModel> get shippingPlacesList => _shippingPlacesList;
  String? get paymentType => _paymentType;
  int? get paymentIndex => _paymentIndex;
  int? get indexType => _indexType;
  int? get shippingPlacesIndex => _shippingPlacesIndex;
  double get amount => _amount;
  // double totalAmount(double discount) => _amount - discount;
  bool get isLoading => _isLoading;
  bool get isLoadingSuggestions => _isLoadingSuggestions;
  List<Product> get suggestedProducts => _suggestedProducts;
  int? get shippingCitiesIndex => _shippingCitiesIndex;
  bool get isLoadingCities => _isLoadingCities;
  List<ShippingAreaModel> get shippingAreasList => _shippingAreasList;
  int? get shippingAreasIndex => _shippingAreasIndex;
  bool get isLoadingAreas => _isLoadingAreas;
  // double get shippingPrice => _shippingAreasIndex == null ? 0 : _shippingAreasList[_shippingAreasIndex!].price;
  ShippingAreaModel? get selectedShippingArea => _shippingAreasIndex == null || _shippingAreasList.isEmpty ? null : _shippingAreasList[_shippingAreasIndex!];
  double _getShippingPrice(int? index) => index == null ? 0 : _shippingAreasList[index].price;
  double get shippingPrice => _shippingPrice;

  List<ShippingCityModel> get shippingCitiesList => _shippingCitiesList;

  Future<void> getSuggestedProductsIfNotExists(String clientId) async {
    if(_suggestedProducts.isEmpty){
      return getSuggestedProducts(clientId);
    }
  }

  Future<void> getSuggestedProducts(String clientId) async {
    _isLoadingSuggestions = true;
    notifyListeners();

    final apiResponse = await cartRepo.getSuggestedProducts(clientId);
    if (apiResponse.response?.statusCode == 200) {
      _suggestedProducts = [];
      _suggestedProducts = List.from(
        apiResponse.response!.data.map((e) => Product.fromJson(e)),
      );
    }
    _isLoadingSuggestions = false;
    notifyListeners();
  }

  Future<void> addSuggestedProduct({
    required String clientId,
    required String? productId,
  }) async {
    debugPrint('addSuggestedProduct');
    // check if product is not in the cart to add as suggested product
    bool productInCart = false;

    for (var cartI in _cartList) {
      if (cartI.id == productId) {
        productInCart = true;
        break;
      }
    }
    debugPrint('- product $productId ${productInCart ? 'IS ALREADY IN THE CART' : 'is not in the cart'}');
    if (!productInCart) {
      return _addSuggestedProduct(clientId, productId);
    }
  }

  Future<void> _addSuggestedProduct(String clientId, String? productId) async {
    final apiResponse = await cartRepo.addSuggestedProducts(clientId, productId);
    if (apiResponse.response?.statusCode == 200) {
      // You could do something here!
    }
  }

  void getCartData() {
    _cartList = [];
    _amount = 0;
    _cartList.addAll(cartRepo.getCartList());
    _cartList.forEach((cart) {
      _amount += (cart.price! * cart.quantity!);
    });
    _shippingPrice = _getShippingPrice(_shippingAreasIndex);
    _amount += _shippingPrice;
  }


  void initPaymentTypeList(BuildContext context) async {
    if (_paymentTypeList.length == 0) {
      ApiResponse apiResponse = await cartRepo.getPaymentTypeList(context);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _paymentTypeList.clear();
        _paymentTypeList.addAll(apiResponse.response!.data);
        _paymentType = apiResponse.response!.data[0];
      }
      else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  updatePaymentType(String? value) {
    _paymentType = value!;
    if(value.contains("Google")){
      _indexType = 1;
    }
    else if(value.contains("Apple")){
      _indexType = 2;
    }
    else if(value.contains("Credit")){
      _indexType = 3;
    }
    notifyListeners();
  }

  void addToCart(ItemsCartModel item) {
    _cartList.add(item);
    cartRepo.addToCartList(_cartList);
    _amount = _amount + (item.price! * item.quantity!);
    notifyListeners();
  }

  void clearCart() {
    _amount = 0.0;
    _cartList.clear();
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _amount = _amount - (_cartList[index].price! * _cartList[index].quantity!);
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }

  Future<int?> isAddedInCart(String? productId, String? variantId)async{
    int? index = -1;
    index = _cartList.indexWhere((element) => (element.id == productId &&
        element.variantId == variantId));
    return index;
  }

  void setQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity! + 1;
      _amount = _amount + _cartList[index].price!;
    } else {
      _cartList[index].quantity = _cartList[index].quantity! - 1;
      _amount = _amount - _cartList[index].price!;
    }
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }

  Future<void> getShippingPlaces(BuildContext context) async {
    final apiResponse = await cartRepo.getShippingPlaces();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _shippingPlacesList = [];
      _shippingPlacesList = List.from(apiResponse.response!.data['shipping']).map((e) => GovernorateModel.fromJson(e)).toList();
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> getShippingCities(BuildContext context, {required int govIndex}) async {
    _shippingCitiesIndex = null;
    _shippingCitiesList = [];
    _shippingAreasIndex = null;
    _shippingAreasList = [];
    _isLoadingCities = true;
    notifyListeners();

    final apiResponse = await cartRepo.getShippingCities(_shippingPlacesList[govIndex].govId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _shippingPlacesIndex = govIndex;
      _shippingCitiesList = List.from(apiResponse.response!.data).map((e) => ShippingCityModel.fromJson(e)).toList();
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoadingCities = false;
    notifyListeners();
  }

  Future<void> getShippingAreas(BuildContext context, {required int cityIndex}) async {
    _shippingAreasIndex = null;
    _shippingAreasList = [];
    _isLoadingAreas = true;
    notifyListeners();

    final apiResponse = await cartRepo.getShippingAreas(_shippingCitiesList[cityIndex].zoneId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _shippingCitiesIndex = cityIndex;
      _shippingAreasList = List.from(apiResponse.response!.data).map((e) => ShippingAreaModel.fromJson(e)).toList();
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }

    _isLoadingAreas = false;
    notifyListeners();
  }


  void setSelectedShippingAreaId(int index) {
    debugPrint('setSelectedShippingAreaId');
    debugPrint('index = $index');
    debugPrint('amount was: $_amount');
    debugPrint('shippingPrice was: $_shippingPrice');
    _shippingAreasIndex = index;
    _amount = _amount - _shippingPrice + _getShippingPrice(index);
    _shippingPrice = _getShippingPrice(index);
    debugPrint('shippingPrice now: $_shippingPrice');
    debugPrint('amount now: $_amount');
    notifyListeners();
  }
}