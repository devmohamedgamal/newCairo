import 'package:newcairo/localization/app_localization.dart';
import 'package:flutter/material.dart';

String getTranslated(String key, BuildContext context) {
  return AppLocalization.of(context)?.translate(key) ?? key;
}

extension GetTranslatedExtension on String {
  String tr(BuildContext context) => getTranslated(this, context);
}
