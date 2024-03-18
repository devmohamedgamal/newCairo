import 'package:lemirageelevators/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});

  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;

  void initSharedPrefData() {
    splashRepo.initSharedData();
  }

  bool? showIntro() {
    return splashRepo.showIntro();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }
}
