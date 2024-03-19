// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth_provider.dart';
import '../../screen/auth/auth_screen.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 30),
          child: Text(getTranslated('want_to_sign_out', context),
              style: cairoBold, textAlign: TextAlign.center),
        ),

        Divider(height: 1, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [

          Expanded(child: InkWell(
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).clearUser().then((condition) {
                Navigator.pop(context);
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
              child: Text(getTranslated('YES', context),
                  style: cairoBold.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.RED,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('NO', context),
                  style: cairoBold.copyWith(color: ColorResources.WHITE)),
            ),
          )),
        ]),
      ]),
    );
  }
}