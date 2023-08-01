import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/baseWidget/show_custom_snakbar.dart';

class GoogleSignInProvider with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  GoogleSignInAuthentication? auth;

  Future<void> login(BuildContext context) async {
    try {
      googleAccount = await _googleSignIn.signIn();
      auth = await googleAccount!.authentication;
    } catch (error) {
      showCustomSnackBar("${error}", context);
    }
    notifyListeners();
  }

  logout() async {
    this.googleAccount = await _googleSignIn.signOut();
    notifyListeners();
  }
}