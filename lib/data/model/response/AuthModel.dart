class AuthModel {
  bool? status;
  String? massage;
  User? userData;

  AuthModel({
    this.status,
    this.massage,
    this.userData,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    status: json["status"],
    massage: json["massage"],
    userData: json["user_data"] == null ? null : User.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "massage": massage,
    "user_data": userData!.toJson(),
  };
}

class User {
  String? userId;
  String? fullName;
  String? clientName;
  String? email;
  String? mobile;
  String? address;
  String? avatar;
  String? password;
  int? signWith;

  User({
    this.userId,
    this.fullName,
    this.clientName,
    this.email,
    this.mobile,
    this.address,
    this.avatar,
    this.password,
    this.signWith,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    fullName: json["fullname"],
    clientName: json["clientname"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    avatar: json["avatar"],
    password: json["password"],
    signWith: json["signWith"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "fullname": fullName,
    "clientname": clientName,
    "email": email,
    "mobile": mobile,
    "address": address,
    "avatar": avatar,
    "password": password,
    "signWith": signWith ?? null,
  };
}