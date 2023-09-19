import 'package:dio/dio.dart';

class CartModel {
  int? _clientId;
  String? _note;
  String? _orderMobile;
  String? _orderAddress;
  int? _paymentMethod; // 1 cash && 2 mastercard && 3 fawry
  int? _m_pay; // 1 Google pay && 2 apple pay && 3 credit card
  String? _address;
  String? _arriveWay;
  int? _shipping;
  String? _mobileType;
  String? _totalAmount;
  List<CartItem>? _cart;

  // fawry
  String? _customerMobile;

  //mastercard
  String? _cardNumber;
  String? _year;
  String? _month;
  String? _pass;

  // Shipping address
  late final String? govId;
  late final String? cityId;
  late final String? zoneId;

  CartModel(
    this._clientId,
    this._note,
    this._orderMobile,
    this._orderAddress,
    this._paymentMethod,
    this._m_pay,
    this._address,
    this._arriveWay,
    this._shipping,
    this._cart,
    this._totalAmount,
    this._mobileType,
    this._customerMobile,
    this._cardNumber,
    this._pass,
    this._year,
    this._month, {
    required this.govId,
    required this.cityId,
    required this.zoneId,
  });

  int? get clientId => _clientId;

  String? get note => _note;

  String? get orderMobile => _orderMobile;

  String? get orderAddress => _orderAddress;

  int? get paymentMethod => _paymentMethod;

  int? get m_pay => _m_pay;

  String? get address => _address;

  String? get arriveWay => _arriveWay;

  int? get shipping => _shipping;

  List<CartItem>? get cart => _cart;

  String? get totalAmount => _totalAmount;

  String? get mobileType => _mobileType;

  String? get customerMobile => _customerMobile;

  String? get cardNumber => _cardNumber;

  String? get pass => _pass;

  String? get year => _year;

  String? get month => _month;

  CartModel.fromJson(Map<String, dynamic> json) {
    _clientId = json['clientid'];
    _note = json['note'];
    _orderMobile = json['order_mobile'];
    _orderAddress = json['order_address'];
    _paymentMethod = json['payment_method'];
    _m_pay = json['m_pay'];
    _address = json['addr'];
    _arriveWay = json['arrive_way'];
    _shipping = json['shipping'];
    _mobileType = json['mobile_type'];
    _totalAmount = json['total_amount'];
    _customerMobile = json['customer_mobile'];
    _cardNumber = json['card_number'];
    _month = json['month'];
    _year = json['year'];
    _pass = json['pass'];
    govId = json['gov_id'];
    cityId = json['city_id'];
    zoneId = json['zone_id'];
    _cart = List<CartItem>.from(json["cart"].map((x) => CartItem.fromJson(x)));
  }

  Map<String, dynamic> toJson(dynamic paymentMethod) {
    return {
      'clientid': _clientId,
      'note': _note,
      'customer_mobile': _orderMobile,
      'order_mobile': _orderMobile,
      'order_address': _orderAddress,
      'payment_method': paymentMethod,
      'addr': _address,
      'arrive_way': _arriveWay,
      'shipping': _shipping,
      'total_amount': _totalAmount,
      'total': _totalAmount,
      'mobile_type': _mobileType,
      'gov_id': govId,
      'city_id': cityId,
      'zone_id': zoneId,
      'cart': List<dynamic>.from(_cart!.map((x) => x.toJson())),
    };
  }
}

class CartItem {
  int? _idKind;
  int? _productId;
  int? _qty;

  CartItem(this._idKind, this._productId, this._qty);

  int? get idKind => _idKind;

  int? get productId => _productId;

  int? get qty => _qty;

  CartItem.fromJson(Map<String, dynamic> json) {
    _idKind = json['id_kind'];
    _productId = json['product_id'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_kind'] = this._idKind;
    data['product_id'] = this._productId;
    data['qty'] = this._qty;
    return data;
  }
}
