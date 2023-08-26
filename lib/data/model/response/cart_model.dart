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
    this._month,
  );

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
    _cart = List<CartItem>.from(json["cart"].map((x) => CartItem.fromJson(x)));
  }

  //1- cash
  Map<String, dynamic> toJsonCash() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientid'] = this._clientId;
    data['note'] = this._note;
    data['order_mobile'] = this._orderMobile;
    data['order_address'] = this._orderAddress;
    data['payment_method'] = this._paymentMethod;
    data['addr'] = this._address;
    data['arrive_way'] = this._arriveWay;
    data['shipping'] = this._shipping;
    data['total_amount'] = this._totalAmount;
    data['cart'] = List<dynamic>.from(_cart!.map((x) => x.toJson()));
    return data;
  }

  //2- mastercard
  Map<String, dynamic> toJsonMasterCard(String PaymentMethod) {
    // "clientid":1237,
    //    "note":"test",
    //    "customer_mobile":"01501733013",
    //    "order_mobile":"01013688983",
    //    "order_address":"kljjh",
    //    "payment_method":"card_pay_mob",
    //    "addr":"London",
    //    "arrive_way":"Home",
    //    "shipping":1,
    //    "total_amount":1535.0,
    //    "mobile_type":"android",

    //    "cart":[
    //       {"id_kind": 19951, "product_id": 794, "qty": 1}
    //    ]
    // }
    return {
      'clientid': _clientId,
      'note': _note,
      'customer_mobile': _orderMobile,
      'order_mobile': _orderMobile,
      'order_address': _orderAddress,
      'payment_method': PaymentMethod,
      'addr': _address,
      'arrive_way': _arriveWay,
      'shipping': _shipping,
      'total_amount': _totalAmount,
      'mobile_type': _mobileType,
      // 'customer_mobile']:=._customerMobile,
      // 'card_number']:=._cardNumber,
      // 'month']:=._month,
      // 'year']:=._year,
      // 'pass']:=._pass,
      'cart': List<dynamic>.from(_cart!.map((x) => x.toJson())),
    };
  }

  //3- fawry
  Map<String, dynamic> toJsonFawry() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientid'] = _clientId;
    data['note'] = _note;
    data['order_mobile'] = this._orderMobile;
    data['order_address'] = this._orderAddress;
    data['payment_method'] = this._paymentMethod;
    data['addr'] = this._address;
    data['arrive_way'] = this._arriveWay;
    data['shipping'] = this._shipping;
    data['total_amount'] = this._totalAmount;
    data['mobile_type'] = this._mobileType;
    data['customer_mobile'] = this._customerMobile;
    data['cart'] = List<dynamic>.from(_cart!.map((x) => x.toJson()));
    return data;
  }

  //6- cash app
  Map<String, dynamic> toJsonCashApp() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientid'] = this._clientId;
    data['note'] = this._note;
    data['order_mobile'] = this._orderMobile;
    data['order_address'] = this._orderAddress;
    data['payment_method'] = this._paymentMethod;
    data['m_pay'] = this._m_pay;
    data['addr'] = this._address;
    data['arrive_way'] = this._arriveWay;
    data['shipping'] = this._shipping;
    data['total_amount'] = this._totalAmount;
    data['mobile_type'] = this._mobileType;
    data['customer_mobile'] = this._customerMobile;
    data['cart'] = List<dynamic>.from(_cart!.map((x) => x.toJson()));
    return data;
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
