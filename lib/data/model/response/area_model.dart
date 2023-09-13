import 'package:flutter/material.dart';
import 'package:lemirageelevators/helper/api_data_helper.dart';
import 'package:lemirageelevators/helper/get_translated_name.dart';

class ShippingAreaModel {
  late final String id;
  late final String govId;
  late final String nameAr;
  late final String nameEn;
  late final String zoneId;
  late final String districtId;
  late final double price;

  String getLocalizedName(BuildContext context) => context.getLocalizedName(ar: nameAr, en: nameEn);

  ShippingAreaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    govId = json['gov_id'];
    nameAr = json['districtOtherName'];
    nameEn = json['districtName'];
    zoneId = json['zone_id'];
    districtId = json['districtId'];
    price = ApiDataHelper.getDouble(json['price']) ?? 0;
  }
}
