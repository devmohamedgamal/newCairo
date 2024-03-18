import 'package:flutter/cupertino.dart';

class NavigationServices {
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arg}) {
    return navigatorKey!.currentState!.pushNamed(routeName, arguments: arg);
  }

  Future<dynamic> navigateToReplacement(String routeName, {dynamic arg}) {
    return navigatorKey!.currentState!
        .pushReplacementNamed(routeName, arguments: arg);
  }

  Future<dynamic>? navigateToReplacementUntil(String? routeName,
      {dynamic arg}) {
    return navigatorKey!.currentState?.pushNamedAndRemoveUntil(
        routeName!, (Route route) => false,
        arguments: arg);
  }

  void goBack() {
    return navigatorKey!.currentState!.pop();
  }
}
