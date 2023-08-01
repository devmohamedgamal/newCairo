import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../baseWidget/button/custom_button.dart';
import '../../baseWidget/dialog/animated_custom_dialog.dart';
import '../../baseWidget/my_dialog.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/textfield/custom_textfield.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        decoration: BoxDecoration(
          image: Provider.of<ThemeProvider>(context).darkTheme
              ? null
              : DecorationImage(
                  image: AssetImage(Images.background), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            SafeArea(
                child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () => Navigator.pop(context),
              ),
            )),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(50),
                      child: Image.asset(Images.logo, height: 150, width: 200),
                    ),
                    Text(getTranslated('FORGET_PASSWORD', context)!,
                        style: cairoSemiBold),
                    Row(children: [
                      Expanded(
                          flex: 1,
                          child: Divider(
                              thickness: 1,
                              color: Theme.of(context).primaryColor)),
                      Expanded(
                          flex: 2,
                          child: Divider(
                              thickness: 0.2,
                              color: Theme.of(context).primaryColor)),
                    ]),
                    Text(
                        getTranslated(
                            'enter_email_for_password_reset', context)!,
                        style: cairoRegular.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      controller: _controller,
                      hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 100),

                    Builder(
                      builder: (context) => !Provider.of<AuthProvider>(context)
                              .isLoading
                          ? CustomButton(
                              buttonText: getTranslated('send_email', context)!,
                              onTap: () {
                                if (_controller.text.isEmpty) {
                                  showCustomSnackBar(
                                      getTranslated(
                                          'EMAIL_MUST_BE_REQUIRED', context)!,
                                      context);
                                }
                                else {
                                  Provider.of<AuthProvider>(context,listen: false)
                                      .forgetPassword(_controller.text.trim(),_route);
                                }
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor))),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  _route(bool isSuccess,String message){
    if (isSuccess) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      _controller.clear();

      showAnimatedDialog(
          context,
          MyDialog(
            icon: Icons.send,
            title:
            getTranslated('sent', context)!,
            description: getTranslated(
                'recovery_link_sent', context)!,
            rotateAngle: 5.5,
            back: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          dismissible: false);
    }
    else {
      showCustomSnackBar(message, context);
    }
  }
}