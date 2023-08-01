import 'package:dio/dio.dart';

class UserInfoModel {
  String? clientId;
  String? fullName;
  String? clientName;
  String? email;
  String? mobile;
  String? address;
  String? password;
  MultipartFile? avatar;

  UserInfoModel({this.clientId,this.fullName,this.clientName,this.email,
    this.mobile,this.address,this.password,this.avatar});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    clientId: json['clientid'],
    fullName: json['fullname'],
    clientName: json['clientname'],
    email: json['email'],
    mobile: json['mobile'],
    address: json['address'],
    password: json['password'],
    avatar: json['avatar'],
  );

  FormData toJson() {
    return FormData.fromMap({
    'clientid': this.clientId,
    'fullname': this.fullName,
    'clientname': this.clientName,
    'email': this.email,
    'mobile': this.mobile,
    'address': this.address,
    'password': this.password,
    'avatar': this.avatar,
    });
  }
}