import 'package:dio/dio.dart';

class RegisterModel {
  String? fullName;
  String? clientName;
  String? email;
  String? password;
  String? mobile;
  String? address;
  String? tokenId;

  RegisterModel({this.fullName,this.clientName,this.email,
    this.password,this.mobile,this.address,this.tokenId});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullname'];
    clientName = json['clientname'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    tokenId = json['token_id'];
    password = json['password'];
  }


  Map<String, dynamic> toJson() =>{
    'fullname': fullName,
    'clientname': clientName,
    'email': email,
    'mobile': mobile,
    'address': address,
    'token_id': tokenId,
    'password': password,
  };

  FormData toJsonApi() {
    return FormData.fromMap({
      'fullname': this.fullName,
      'clientname': this.clientName,
      'email': this.email,
      'mobile': this.mobile,
      'address': this.address,
      'token_id': this.tokenId,
      'password': this.password,
    });
  }
}