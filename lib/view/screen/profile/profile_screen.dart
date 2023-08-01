import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/AuthModel.dart';
import '../../../data/model/response/user_info_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../baseWidget/button/custom_button.dart';
import '../../baseWidget/dialog/animated_custom_dialog.dart';
import '../../baseWidget/dialog/delete_account_confirmation_dialog.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/textfield/custom_password_textfield.dart';
import '../../baseWidget/textfield/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _uNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  UserInfoModel updateUserInfoModel = UserInfoModel();
  File? file;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, profile, child) {
          _fullNameController.text = profile.user!.fullName ?? "";
          _userNameController.text = profile.user!.clientName ?? "";
          _emailController.text = profile.user!.email ?? "";
          _mobileController.text = profile.user!.mobile ?? "";
          _addressController.text = profile.user!.address ?? "";
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                Images.toolbar_background,
                fit: BoxFit.fill,
                height: 500,
                color: Provider.of<ThemeProvider>(context).darkTheme
                    ? Colors.black
                    : null,
              ),

              Container(
                padding: EdgeInsets.only(top: 40, left: 15,right: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        CupertinoNavigationBarBackButton(
                          onPressed: () => Navigator.of(context).pop(),
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(getTranslated('PROFILE', context)!,
                            style: cairoRegular.copyWith(
                                fontSize: 20, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ]),

                      CircleAvatar(
                        backgroundColor: ColorResources.BLACK.withOpacity(0.2),
                        radius: 20,
                        child: IconButton(
                            onPressed: () => showAnimatedDialog(
                                context, DeleteAccountConfirmationDialog(), isFlip: true),
                            icon: Icon(Icons.delete_forever,
                                color: ColorResources.RED))
                      )
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: file == null
                                    ? FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        image:
                                            '${AppConstants.BASE_URL_IMAGE}${profile.user!.avatar}',
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(Images.placeholder,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover),
                                      )
                                    : Image.file(file!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill),
                              ),
                              Positioned(
                                bottom: 0,
                                right: -10,
                                child: CircleAvatar(
                                  backgroundColor:
                                      ColorResources.LIGHT_SKY_BLUE,
                                  radius: 14,
                                  child: IconButton(
                                    onPressed: _choose,
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.edit,
                                        color: ColorResources.WHITE, size: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          profile.user!.fullName ?? "",
                          style: cairoSemiBold.copyWith(
                              color: ColorResources.WHITE, fontSize: 20.0),
                        )
                      ],
                    ),
                    SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.getIconBg(context),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  Dimensions.MARGIN_SIZE_DEFAULT),
                              topRight: Radius.circular(
                                  Dimensions.MARGIN_SIZE_DEFAULT),
                            )),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            // user name && full name
                            Container(
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: ColorResources
                                                  .getLightSkyBlue(context),
                                              size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text(
                                              getTranslated(
                                                  'FULL_NAME', context)!,
                                              style: cairoRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputType: TextInputType.name,
                                        focusNode: _fNameFocus,
                                        nextNode: _uNameFocus,
                                        hintText: getTranslated(
                                            'FULL_NAME', context)!,
                                        controller: _fullNameController,
                                      ),
                                    ],
                                  )),
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: ColorResources
                                                  .getLightSkyBlue(context),
                                              size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text(
                                              getTranslated(
                                                  'USER_NAME', context)!,
                                              style: cairoRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputType: TextInputType.name,
                                        focusNode: _uNameFocus,
                                        nextNode: _emailFocus,
                                        hintText: getTranslated(
                                            'USER_NAME', context)!,
                                        controller: _userNameController,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),

                            // for Email
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.alternate_email,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      SizedBox(
                                        width:
                                            Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                      ),
                                      Text(getTranslated('EMAIL', context)!,
                                          style: cairoRegular)
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.emailAddress,
                                    focusNode: _emailFocus,
                                    nextNode: _mobileFocus,
                                    hintText: getTranslated('EMAIL', context)!,
                                    controller: _emailController,
                                  ),
                                ],
                              ),
                            ),

                            // for Phone No
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.dialpad,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      SizedBox(
                                          width: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Text(getTranslated('PHONE_NO', context)!,
                                          style: cairoRegular)
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    focusNode: _mobileFocus,
                                    nextNode: _addressFocus,
                                    hintText:
                                        getTranslated('PHONE_NO', context)!,
                                    controller: _mobileController,
                                    isPhoneNumber: true,
                                  ),
                                ],
                              ),
                            ),

                            // for address
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_city,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      SizedBox(
                                          width: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Text(getTranslated('address', context)!,
                                          style: cairoRegular)
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.streetAddress,
                                    focusNode: _addressFocus,
                                    nextNode: _passwordFocus,
                                    hintText:
                                        getTranslated('address', context)!,
                                    controller: _addressController,
                                  ),
                                ],
                              ),
                            ),

                            // for Password
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.lock_open,
                                          color: ColorResources.getPrimary(
                                              context),
                                          size: 20),
                                      SizedBox(
                                          width: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Text(getTranslated('PASSWORD', context)!,
                                          style: cairoRegular)
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomPasswordTextField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    nextNode: _confirmPasswordFocus,
                                    hintTxt:
                                        getTranslated('PASSWORD', context)!,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ],
                              ),
                            ),

                            // for re-enter Password
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.lock_open,
                                          color: ColorResources.getPrimary(
                                              context),
                                          size: 20),
                                      SizedBox(
                                          width: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Text(
                                          getTranslated(
                                              'RE_ENTER_PASSWORD', context)!,
                                          style: cairoRegular)
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomPasswordTextField(
                                    controller: _confirmPasswordController,
                                    focusNode: _confirmPasswordFocus,
                                    textInputAction: TextInputAction.done,
                                    hintTxt: getTranslated(
                                        'RE_ENTER_PASSWORD', context)!,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.MARGIN_SIZE_LARGE,
                          vertical: Dimensions.MARGIN_SIZE_SMALL),
                      child: !Provider.of<ProfileProvider>(context).isLoading
                          ? CustomButton(
                              onTap: _updateUserAccount,
                              buttonText:
                                  getTranslated('UPDATE_ACCOUNT', context)!)
                          : Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor))),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // choose picture
  void _choose() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // update User Account
  _updateUserAccount() async {
    String _firstName = _fullNameController.text.trim();
    String _userName = _userNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = _mobileController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();

    if (_firstName.isEmpty || _userName.isEmpty) {
      showCustomSnackBar(
          getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!, context);
    } else if (_email.isEmpty) {
      showCustomSnackBar(
          getTranslated('EMAIL_MUST_BE_REQUIRED', context)!, context);
    } else if (_phoneNumber.isEmpty) {
      showCustomSnackBar(
          getTranslated('PHONE_MUST_BE_REQUIRED', context)!, context);
    } else if (_password.isEmpty) {
      showCustomSnackBar(
          getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!, context);
    } else if (_confirmPassword.isEmpty) {
      showCustomSnackBar(
          getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!,
          context);
    } else if ((_password.isNotEmpty && _password.length < 6) ||
        (_confirmPassword.isNotEmpty && _confirmPassword.length < 6)) {
      showCustomSnackBar(
          getTranslated("Password_character", context)!, context);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar(
          getTranslated('PASSWORD_DID_NOT_MATCH', context)!, context);
    } else {
      updateUserInfoModel.clientId =
          Provider.of<AuthProvider>(context, listen: false).user!.userId!;
      updateUserInfoModel.clientName = _userNameController.text;
      updateUserInfoModel.fullName = _fullNameController.text;
      updateUserInfoModel.email = _emailController.text;
      updateUserInfoModel.mobile = _mobileController.text;
      updateUserInfoModel.address = _addressController.text;
      updateUserInfoModel.password = _passwordController.text;
      if (file != null) {
        final mimeType = lookupMimeType(file!.path);
        updateUserInfoModel.avatar = await MultipartFile.fromFile(
          file!.path,
          filename: file!.path.split('/').last,
          contentType: MediaType("${mimeType!.split('/').first}",
              "${file!.path.split(".").last}"), //important
        );
      }

      await Provider.of<ProfileProvider>(context, listen: false)
          .updateUserInfo(updateUserInfoModel, context, _route);
    }
  }

  _route(bool status, String message) async {
    if (status) {
      await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(
          context,
          Provider.of<AuthProvider>(context, listen: false).user!.userId!);
      showCustomSnackBar(message, context, isError: false);
      Provider.of<AuthProvider>(context, listen: false).saveUser(User(
        userId: Provider.of<ProfileProvider>(context, listen: false)
            .clientProfileModel!
            .clientData!
            .clientId,
        fullName: Provider.of<ProfileProvider>(context, listen: false)
            .clientProfileModel!
            .clientData!
            .fullName,
        clientName: Provider.of<ProfileProvider>(context, listen: false)
            .clientProfileModel!
            .clientData!
            .clientName,
        email: Provider.of<ProfileProvider>(context, listen: false)
            .clientProfileModel!
            .clientData!
            .email,
        mobile: Provider.of<ProfileProvider>(context, listen: false)
            .clientProfileModel!
            .clientData!
            .mobile,
        address: Provider.of<ProfileProvider>(context, listen: false)
            .clientProfileModel!
            .clientData!
            .address,
        avatar: Provider.of<ProfileProvider>(context, listen: false)
            .clientProfileModel!
            .clientData!
            .avatar,
        password: _passwordController.text.trim(),
      ));
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() {});
    } else {
      showCustomSnackBar(message, context);
    }
  }
}
