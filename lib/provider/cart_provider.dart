import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/home_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/items_cart_model.dart';
import '../data/model/response/shipping_places_model.dart';
import '../data/repository/cart_repo.dart';
import '../helper/api_checker.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({required this.cartRepo});

  List<String> _paymentTypeList = [];
  List<ItemsCartModel> _cartList = [];
  List<Places> _shippingPlacesList = [];
  String _paymentType = '';
  int? _indexType;
  String? _shippingPlacesId;
  int? _shippingPlacesIndex = 0;
  int? _paymentIndex = 0;
  double _amount = 0.0;
  bool _isLoading = false;
  bool _isLoadingSuggestions = false;
  List<Product> _suggestedProducts = [];

  List<String> get paymentTypeList => _paymentTypeList;
  List<ItemsCartModel> get cartList => _cartList;
  List<Places> get shippingPlacesList => _shippingPlacesList;
  String? get shippingPlacesId => _shippingPlacesId;
  String? get paymentType => _paymentType;
  int? get paymentIndex => _paymentIndex;
  int? get indexType => _indexType;
  int? get shippingPlacesIndex => _shippingPlacesIndex;
  double get amount => _amount;
  bool get isLoading => _isLoading;
  bool get isLoadingSuggestions => _isLoadingSuggestions;
  List<Product> get suggestedProducts => _suggestedProducts;

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
    _amount = 0.00;
    _cartList.addAll(cartRepo.getCartList());
    _cartList.forEach((cart) {
      if(_shippingPlacesList.isNotEmpty){
        _amount = _amount + (cart.price! * cart.quantity!) +
            double.parse(_shippingPlacesList[_shippingPlacesIndex ?? 0].price ?? "0.0");
      }
      else{
        _amount = _amount + (cart.price! * cart.quantity!);
      }
    });
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
    ApiResponse apiResponse = await cartRepo.getShippingPlaces();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _shippingPlacesList = [];
      ShippingPlacesModel placesModel;
      placesModel = ShippingPlacesModel.fromJson(apiResponse.response!.data);
      _shippingPlacesList = placesModel.shipping ?? [];
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void setSelectedShippingPlacesId(index,oldIndex) {
    _shippingPlacesId = _shippingPlacesList[index].id;
    _shippingPlacesIndex = index;
    _amount = (_amount - double.parse(_shippingPlacesList[oldIndex].price ?? "0.0"))
        + double.parse(_shippingPlacesList[index].price ?? "0.0");
    notifyListeners();
  }
}