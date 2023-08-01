import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/images.dart';
import 'package:provider/provider.dart';
import '../../localization/language_constrants.dart';
import '../../provider/auth_provider.dart';
import '../../util/dimensions.dart';
import '../../util/responsive.dart';
import '../../util/textStyle.dart';
import '../screen/auth/auth_screen.dart';
import 'button/custom_button.dart';

class NotLoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(height(context) * 0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.login, height: height(context) * 0.2,
                width: width(context)),
            SizedBox(height: height(context) * 0.05),
            Text(getTranslated('PLEASE_LOGIN_FIRST', context)!,
                textAlign: TextAlign.center,
                style: cairoSemiBold.copyWith(fontSize: height(context) * 0.017)),
            SizedBox(height: height(context) * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: CustomButton(
                buttonText: getTranslated('LOGIN', context)!,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthScreen())),
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).updateSelectedIndex(1);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthScreen(initialPage: 1)));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height(context) * 0.02),
                child: Text(getTranslated('create_new_account', context)!,
                    style: cairoRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                )),
              ),
            ),
          ],
        ));
  }
}