import 'package:flutter/material.dart';
import 'package:lemirageelevators/helper/get_translated_name.dart';

class ShippingCityModel {
  late final String id;
  late final String governorateId;
  late final String nameAr;
  late final String nameEn;
  late final String zoneId;

  String getLocalizedName(BuildContext context) =>
      context.getLocalizedName(ar: nameAr, en: nameEn);

  ShippingCityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateId = json['gov_id'];
    nameEn = json['titleEN'];
    nameAr = json['title'];
    zoneId = json['zone_id'];
  }
}
