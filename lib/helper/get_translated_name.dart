import 'package:flutter/cupertino.dart';
import 'package:lemirageelevators/provider/localization_provider.dart';
import 'package:provider/provider.dart';

extension GetTranslationNameOnLocalization on BuildContext {
  /// get localized name based on current app localization
  String getLocalizedName({
    required String ar,
    required String en,
  }) {
    return Provider.of<LocalizationProvider>(this).locale!.languageCode == "en"
        ? en
        : ar;
  }
}
