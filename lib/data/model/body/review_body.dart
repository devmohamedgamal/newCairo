import 'package:dio/dio.dart';

class ReviewBody {
  String? _clientId;
  String? _productId;
  String? _rate;
  String? _message;

  ReviewBody(
      {String? clientId, String? productId, String? rate, String? message}) {
    this._clientId = clientId;
    this._productId = productId;
    this._rate = rate;
    this._message = message;
  }

  String? get clientId => _clientId;
  String? get productId => _productId;
  String? get rate => _rate;
  String? get message => _message;

  ReviewBody.fromJson(Map<String, dynamic> json) {
    _clientId = json['clientid'];
    _productId = json['productid'];
    _rate = json['rate'];
    _message = json['message'];
  }

  FormData toJsonApi() {
    return FormData.fromMap({
      'clientid': this._clientId,
      'productid': this._productId,
      'rate': this._rate,
      'message': this._message,
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientid'] = this._clientId;
    data['productid'] = this._productId;
    data['rate'] = this._rate;
    data['message'] = this._message;
    return data;
  }
}
