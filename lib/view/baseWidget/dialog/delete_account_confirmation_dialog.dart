// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/cart_provider.dart';
import 'package:lemirageelevators/provider/facebook_login_provider.dart';
import 'package:lemirageelevators/provider/google_sign_in_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../screen/auth/auth_screen.dart';

class DeleteAccountConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 30),
          child: Text(getTranslated('delete_account', context)!,
              style: cairoBold, textAlign: TextAlign.center),
        ),

        Divider(height: 1, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [
          // yes
          Expanded(child: InkWell(
            onTap: () {
              // //google
              // if(Provider.of<AuthProvider>(context, listen: false).user!.signWith == 1){
              //   Provider.of<GoogleSignInProvider>(context, listen: false).logout();
              // }
              // //apple
              // else if(Provider.of<AuthProvider>(context, listen: false).user!.signWith == 2){
              //   Provider.of<Apple>(context, listen: false).logout();
              // }
              // //facebook
              // else if(Provider.of<AuthProvider>(context, listen: false).user!.signWith == 3){
              //   Provider.of<FacebookLoginProvider>(context, listen: false).logOut();
              // }
              Provider.of<AuthProvider>(context, listen: false).clearUser().then((condition) {
                Navigator.pop(context);
                Provider.of<CartProvider>(context,listen: false).removeCart();
                Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
                Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();
                Provider.of<AuthProvider>(context,listen: false).clearUser();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => AuthScreen()), (route) => false);
              });
            },
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('YES', context)!,
                  style: cairoBold.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )),

          // no
          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.RED,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('NO', context)!,
                  style: cairoBold.copyWith(color: ColorResources.WHITE)),
            ),
          )),
        ]),
      ]),
    );
  }
}