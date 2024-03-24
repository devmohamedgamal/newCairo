import 'package:newcairo/data/model/body/register_model.dart';
import 'package:newcairo/localization/language_constrants.dart';
import 'package:newcairo/provider/auth_provider.dart';
import 'package:newcairo/util/dimensions.dart';
import 'package:newcairo/view/baseWidget/button/custom_button.dart';
import 'package:newcairo/view/baseWidget/dialog/animated_custom_dialog.dart';
import 'package:newcairo/view/baseWidget/textfield/custom_password_textfield.dart';
import 'package:newcairo/view/baseWidget/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:newcairo/view/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/body/login_model.dart';
import '../../../../helper/email_checker.dart';
import '../../../../util/images.dart';
import '../../../baseWidget/dialog/error_alert_dialog.dart';
import '../../../baseWidget/dialog/language_dialog.dart';
import '../../../baseWidget/show_custom_snakbar.dart';
import '../../../baseWidget/web_view_screen.dart';
import '../../../setting/settings_screen.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState>? _formKey;
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _cNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _mFocus = FocusNode();
  final FocusNode _aFocus = FocusNode();
  final FocusNode _pFocus = FocusNode();
  RegisterModel register = RegisterModel();
  LoginModel loginBody = LoginModel();
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      hintText: getTranslated('FULL_NAME', context),
                      focusNode: _fNameFocus,
                      nextNode: _cNameFocus,
                      capitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      controller: _fullNameController,
                    )),
                    const SizedBox(width: 15),
                    Expanded(
                        child: CustomTextField(
                      hintText: getTranslated('USER_NAME', context),
                      focusNode: _cNameFocus,
                      nextNode: _emailFocus,
                      capitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      controller: _clientNameController,
                    )),
                  ],
                ),
              ),

              // for email
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                  focusNode: _emailFocus,
                  nextNode: _mFocus,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                ),
              ),

              // for mobile
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                  focusNode: _mFocus,
                  nextNode: _aFocus,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                  controller: _mobileController,
                ),
              ),

              // for address
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: getTranslated('add_Address', context),
                  controller: _addressController,
                  focusNode: _aFocus,
                  nextNode: _pFocus,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.streetAddress,
                ),
              ),

              // for password
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('PASSWORD', context),
                  focusNode: _pFocus,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                ),
              ),
            ],
          ),
        ),

        // for register button
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
          child: Provider.of<AuthProvider>(context).isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : CustomButton(
                  onTap: addUser,
                  buttonText: getTranslated('SIGN_UP', context)),
        ),
        SizedBox(
          height: 24,
        ),
        // for change language
        TitleButton(
          image: Images.language,
          title: getTranslated('choose_language', context),
          onTap: () => showAnimatedDialog(context, LanguageDialog()),
        ),
        TitleButton(
          image: Images.about,
          title: getTranslated('Privacy Policy', context),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(
                      url: 'https://www.elbascet.com/newcairo/Website/policy'),
                ));
          },
        ),
      ],
    );
  }

  addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      isEmailVerified = true;

      String fullName = _fullNameController.text.trim();
      String clientName = _clientNameController.text.trim();
      String email = _emailController.text.trim();
      String mobile = _mobileController.text.trim();
      String address = _addressController.text.trim();
      String password = _passwordController.text.trim();

      if (fullName.isEmpty) {
        showCustomSnackBar(
            getTranslated('first_name_field_is_required', context), context);
      } else if (clientName.isEmpty) {
        showCustomSnackBar(
            getTranslated('last_name_field_is_required', context), context);
      } else if (email.isEmpty) {
        showCustomSnackBar(
            getTranslated('EMAIL_MUST_BE_REQUIRED', context), context);
      } else if (EmailChecker.isNotValid(email)) {
        showCustomSnackBar(
            getTranslated('enter_valid_email_address', context), context);
      } else if (mobile.isEmpty) {
        showCustomSnackBar(
            getTranslated('PHONE_MUST_BE_REQUIRED', context), context);
      } else if (address.isEmpty) {
        showCustomSnackBar(
            getTranslated('PHONE_MUST_BE_REQUIRED', context), context);
      } else if (password.isEmpty) {
        showCustomSnackBar(
            getTranslated('PHONE_MUST_BE_REQUIRED', context), context);
      } else {
        Provider.of<AuthProvider>(context, listen: false).getToken();
        register.fullName = _fullNameController.text.trim();
        register.clientName = _clientNameController.text.trim();
        register.email = _emailController.text.trim();
        register.mobile = _mobileController.text.trim();
        register.address = _addressController.text.trim();
        register.tokenId =
            Provider.of<AuthProvider>(context, listen: false).token;
        register.password = _passwordController.text.trim();
        await Provider.of<AuthProvider>(context, listen: false)
            .registration(register, routeLogin);
      }
    } else {
      isEmailVerified = false;
    }
  }

  routeLogin(
      bool isRoute, String email, String password, String errorMessage) async {
    if (isRoute) {
      Provider.of<AuthProvider>(context, listen: false).getToken();
      loginBody.email = email;
      loginBody.password = password;
      loginBody.token = Provider.of<AuthProvider>(context, listen: false).token;
      await Provider.of<AuthProvider>(context, listen: false)
          .login(loginBody, route);
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

  route(bool isRoute, String errorMessage) async {
    var response =
        await Provider.of<AuthProvider>(context, listen: false).about();
    if (isRoute) {
      if (response['fetched_about_data']['landing_page'] == "5") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => WebViewScreen(
                  url:
                      'https://www.elbascet.com/newcairo/Website/home/${loginBody.token}',
                )));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeView()));
      }
    } else {
      showCustomSnackBar(errorMessage, context);
    }
  }
}
