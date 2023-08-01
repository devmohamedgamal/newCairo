import 'package:dio/dio.dart';

class SocialLoginModel {
  String? uuiId;
  String? fullName;
  String? clientName;
  String? email;
  String? mobile;
  String? address;
  String? tokenId;

  SocialLoginModel({this.uuiId,this.fullName,this.clientName,
    this.mobile,this.email,this.address,this.tokenId});

  SocialLoginModel.fromJson(Map<String, dynamic> json) {
    uuiId = json['uuiid'];
    fullName = json['fullname'];
    clientName = json['clientname'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    tokenId = json['token_id'];
  }

  FormData toJson() {
    return FormData.fromMap({
    'uuiid': this.uuiId,
    'fullname': this.fullName,
    'clientname': this.clientName,
    'mobile': this.mobile,
    'email': this.email,
    'address': this.address,
    'token_id': this.tokenId,
    });
  }
}