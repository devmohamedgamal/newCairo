import 'package:lemirageelevators/helper/api_data_helper.dart';

class CouponModel {
  late final String? message;
  late final num discountPercentage;

  CouponModel({
    this.message,
    required this.discountPercentage,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    message = json['massage'];
    discountPercentage = ApiDataHelper.getNum(json['discount_percentage']) ?? 0;
  }
}
