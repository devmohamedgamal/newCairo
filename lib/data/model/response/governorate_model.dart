import 'package:flutter/cupertino.dart';
import 'package:lemirageelevators/helper/get_translated_name.dart';

class GovernorateModel {
  late final String id;
  late final String govId;
  late final String nameAr;
  late final String nameEn;
  late final String code;

  String getLocalizedName(BuildContext context) => context.getLocalizedName(ar: nameAr, en: nameEn);

  GovernorateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    govId = json['government_id'];
    nameEn = json['name'];
    nameAr = json['nameAr'];
    code = json['code'];
  }
}
