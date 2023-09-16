import 'package:lemirageelevators/data/model/body/register_model.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/dimensions.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/button/custom_button.dart';
import 'package:lemirageelevators/view/baseWidget/textfield/custom_password_textfield.dart';
import 'package:lemirageelevators/view/baseWidget/textfield/custom_textfield.dart';
import 'package:lemirageelevators/view/screen/auth/widget/social_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/body/login_model.dart';
import '../../../../helper/email_checker.dart';
import '../../../baseWidget/show_custom_snakbar.dart';
import '../../dashboard/dashboard_screen.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}
class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _clientNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState>? _formKey;
  FocusNode _fNameFocus = FocusNode();
  FocusNode _cNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _mFocus = FocusNode();
  FocusNode _aFocus = FocusNode();
  FocusNode _pFocus = FocusNode();
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
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT),
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
                    SizedBox(width: 15),
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
                margin: EdgeInsets.only(
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
                margin: EdgeInsets.only(
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
                margin: EdgeInsets.only(
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
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
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
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
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
              buttonText: getTranslated('SIGN_UP', context)!),
        ),

        // SocialLoginWidget(),

        // for skip for now
        Provider.of<AuthProvider>(context).isLoading
            ? SizedBox()
            : Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashBoardScreen()));
              },
              child: Text(getTranslated('SKIP_FOR_NOW', context)!,
                  style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: ColorResources.getColombiaBlue(context))),
            )),
      ],
    );
  }

  addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      isEmailVerified = true;

      String _fullName = _fullNameController.text.trim();
      String _clientName = _clientNameController.text.trim();
      String _email = _emailController.text.trim();
      String _mobile = _mobileController.text.trim();
      String _address = _addressController.text.trim();
      String _password = _passwordController.text.trim();

      if (_fullName.isEmpty) {
        showCustomSnackBar(getTranslated('first_name_field_is_required', context)!,context);
      }
      else if (_clientName.isEmpty) {
        showCustomSnackBar(getTranslated('last_name_field_is_required', context)!,context);
      }
      else if (_email.isEmpty) {
        showCustomSnackBar(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!,context);
      }
      else if (EmailChecker.isNotValid(_email)) {
        showCustomSnackBar(getTranslated('enter_valid_email_address', context)!,context);
      }
      else if (_mobile.isEmpty) {
        showCustomSnackBar(getTranslated('PHONE_MUST_BE_REQUIRED', context)!,context);
      }
      else if (_address.isEmpty) {
        showCustomSnackBar(getTranslated('PHONE_MUST_BE_REQUIRED', context)!,context);
      }
      else if (_password.isEmpty) {
        showCustomSnackBar(getTranslated('PHONE_MUST_BE_REQUIRED', context)!,context);
      }
      else {
        Provider.of<AuthProvider>(context,listen: false).getToken();
        register.fullName = _fullNameController.text.trim();
        register.clientName = _clientNameController.text.trim();
        register.email = _emailController.text.trim();
        register.mobile = _mobileController.text.trim();
        register.address = _addressController.text.trim();
        register.tokenId = Provider.of<AuthProvider>(context,listen: false).token;
        register.password = _passwordController.text.trim();
        await Provider.of<AuthProvider>(context,listen: false).registration(register, routeLogin);
      }
    }
    else {
      isEmailVerified = false;
    }
  }

  routeLogin(bool isRoute,String email,String password,String errorMessage) async {
    if (isRoute) {
      Provider.of<AuthProvider>(context,listen: false).getToken();
      loginBody.email = email;
      loginBody.password = password;
      loginBody.token = Provider.of<AuthProvider>(context,listen: false).token;
      await Provider.of<AuthProvider>(context,listen: false).login(loginBody,route);
    }
    else {
      showCustomSnackBar(errorMessage,context);
    }
  }

  route(bool isRoute,String errorMessage) async {
    if (isRoute) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => DashBoardScreen()),(route) => false);
    }
    else {
      showCustomSnackBar(errorMessage,context);
    }
  }
}