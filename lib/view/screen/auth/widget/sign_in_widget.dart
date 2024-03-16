// ignore_for_file: unnecessary_null_comparison
import 'package:lemirageelevators/data/model/body/login_model.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/dimensions.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/button/custom_button.dart';
import 'package:lemirageelevators/view/baseWidget/dialog/animated_custom_dialog.dart';
import 'package:lemirageelevators/view/baseWidget/dialog/error_alert_dialog.dart';
import 'package:lemirageelevators/view/baseWidget/textfield/custom_password_textfield.dart';
import 'package:lemirageelevators/view/baseWidget/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../baseWidget/show_custom_snakbar.dart';
import '../../home/home_screen.dart';
import '../forget_password_screen.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;
  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    if (Provider.of<AuthProvider>(context, listen: false).user != null) {
      _emailController!.text =
          Provider.of<AuthProvider>(context, listen: false).user!.email ?? "";
      _passwordController!.text =
          Provider.of<AuthProvider>(context, listen: false).user!.password ??
              "";
    }
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    return Form(
      key: _formKeyLogin,
      child: ListView(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        children: [
          // for Email
          Container(
            margin: const EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_LARGE,
                right: Dimensions.MARGIN_SIZE_LARGE,
                bottom: Dimensions.MARGIN_SIZE_SMALL),
            child: CustomTextField(
              hintText: getTranslated('ENTER_YOUR_EMAIL', context),
              focusNode: _emailNode,
              nextNode: _passNode,
              textInputType: TextInputType.emailAddress,
              controller: _emailController,
            ),
          ),

          // for Password
          Container(
            margin: const EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_LARGE,
                right: Dimensions.MARGIN_SIZE_LARGE,
                bottom: Dimensions.MARGIN_SIZE_DEFAULT),
            child: CustomPasswordTextField(
              hintTxt: getTranslated('ENTER_YOUR_PASSWORD', context),
              textInputAction: TextInputAction.done,
              focusNode: _passNode,
              controller: _passwordController,
            ),
          ),

          // for remember and forget password
          Container(
            margin: const EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_SMALL,
                right: Dimensions.MARGIN_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Checkbox(
                        checkColor: ColorResources.WHITE,
                        activeColor: Theme.of(context).primaryColor,
                        value: authProvider.isRemember,
                        onChanged: authProvider.updateRemember,
                      ),
                    ),
                    Text(getTranslated('REMEMBER', context),
                        style: cairoRegular),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ForgetPasswordScreen())),
                  child: Text(getTranslated('FORGET_PASSWORD', context),
                      style: cairoRegular.copyWith(
                          color: ColorResources.getLightSkyBlue(context))),
                ),
              ],
            ),
          ),

          // for signIn button
          Container(
            margin: const EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_LARGE,
                right: Dimensions.MARGIN_SIZE_LARGE,
                bottom: Dimensions.MARGIN_SIZE_LARGE,
                top: Dimensions.MARGIN_SIZE_DEFAULT),
            child: Provider.of<AuthProvider>(context).isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : CustomButton(
                    onTap: loginUser,
                    buttonText: getTranslated('SIGN_IN', context)),
          ),
        ],
      ),
    );
  }

  void loginUser() async {
    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();
      String email = _emailController!.text.trim();
      String password = _passwordController!.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar(
            getTranslated('EMAIL_MUST_BE_REQUIRED', context), context);
      } else if (password.isEmpty) {
        showCustomSnackBar(
            getTranslated('PASSWORD_MUST_BE_REQUIRED', context), context);
      } else {
        // await Provider.of<AuthProvider>(context,listen: false).getToken();
        loginBody.email = email;
        loginBody.password = password;
        loginBody.token =
            Provider.of<AuthProvider>(context, listen: false).token;
        await Provider.of<AuthProvider>(context, listen: false)
            .login(loginBody, route);
      }
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeView()),
          (route) => false);
    } else {
      // showCustomSnackBar(errorMessage,context);
      showAnimatedDialog(
        context,
        ErrorAlertDialog(
          errorText: errorMessage,
        ),
        isFlip: true,
      );
    }
  }
}
