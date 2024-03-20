import 'package:flutter/material.dart';
import 'package:newcairo/util/color_resources.dart';

ThemeData dark = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: ColorResources.DEFAULT_COLOR,
  brightness: Brightness.dark,
  highlightColor: Color(0xFF252525),
  hintColor: Color(0xFFc7c7c7),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
