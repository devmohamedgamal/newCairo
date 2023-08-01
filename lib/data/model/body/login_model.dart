// ignore_for_file: prefer_collection_literals, unnecessary_this
import 'package:dio/dio.dart';
class LoginModel {
  String? email;
  String? password;
  String? token;

  LoginModel({
    this.email,
    this.password,
    this.token,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() =>{
    "email": email,
    "password": password,
    "token": token,
  };

  FormData toJsonApi() {
    return FormData.fromMap({
      "email": this.email,
      "password": this.password,
      "token": this.token,
    });
  }
}