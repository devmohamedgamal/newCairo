// ignore_for_file: unnecessary_null_comparison
import 'dart:io';

import 'package:lemirageelevators/data/model/response/social_login_model.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/provider/facebook_login_provider.dart';
import 'package:lemirageelevators/provider/google_sign_in_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/images.dart';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../baseWidget/show_custom_snakbar.dart';
import '../../dashboard/dashboard_screen.dart';

class SocialLoginWidget extends StatefulWidget {
  @override
  _SocialLoginWidgetState createState() => _SocialLoginWidgetState();
}
class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  SocialLoginModel socialLogin = SocialLoginModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width(context)*0.3,
              height: 1,
              color: ColorResources.BLACK.withOpacity(0.2),
            ),

            Center(child: Text(getTranslated('social_login', context)!)),

            Container(
              width: width(context)*0.3,
              height: 1,
              color: ColorResources.BLACK.withOpacity(0.2),
            ),
          ],
        ),

        HSpacer(5),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // google
            Consumer<GoogleSignInProvider>(
              builder: (context, googleSignIn, child) => InkWell(
                onTap: () async{
                  await googleSignIn.login(context);
                  String id,email,fullName;
                  if(googleSignIn.googleAccount != null)
                  {
                    id = googleSignIn.googleAccount!.id;
                    email = googleSignIn.googleAccount!.email;
                    fullName = googleSignIn.googleAccount!.displayName ?? "";

                    Provider.of<AuthProvider>(context,
                        listen: false).getToken();
                    socialLogin.uuiId = id;
                    socialLogin.email = email;
                    socialLogin.tokenId = Provider.of<AuthProvider>(context,
                        listen: false).token ?? "";
                    socialLogin.fullName = fullName;
                    socialLogin.clientName = fullName;
                    socialLogin.mobile = "";
                    socialLogin.address = "";
                    await Provider.of<AuthProvider>(context,
                        listen: false).socialLogin(socialLogin,1,route);
                  }
                },
                child: Ink(
                  color: Color(0xFF397AF3),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white ,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                height: 25,width: 25,
                                child: Image.asset(Images.google)), // <-- Use 'Image.asset(...)' here
                            SizedBox(width: 5),
                            Text('Google',style: TextStyle(fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ),

            // apple
            Platform.isIOS
                ? InkWell(
              onTap: () async{
                final credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                );

                print(credential);

                String id,email,fullName;
                if(credential != null){
                  id = credential.userIdentifier ?? "";
                  email = credential.email ?? "";
                  fullName = credential.givenName ?? "";

                  Provider.of<AuthProvider>(context,listen: false).getToken();
                  socialLogin.uuiId = id;
                  socialLogin.email = email;
                  socialLogin.tokenId = Provider.of<AuthProvider>(context,
                      listen: false).token ?? "";
                  socialLogin.fullName = fullName;
                  socialLogin.clientName = fullName;
                  socialLogin.mobile = "";
                  socialLogin.address = "";
                  await Provider.of<AuthProvider>(context,
                      listen: false).socialLogin(socialLogin,2,route);
                }
              },
              child: Ink(
                color: Color(0xFF397AF3),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(height: 25,width: 25,
                              child: Image.asset(Images.apple)), // <-- Use 'Image.asset(...)' here
                          SizedBox(width: 5),
                          Text('Apple',style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Container(),

            // facebook
            InkWell(
              onTap: () async{
                await Provider.of<FacebookLoginProvider>(context,listen: false).login();
                String id,email,fullName;
                if(Provider.of<FacebookLoginProvider>(context,listen: false).userData != null){
                  id = Provider.of<FacebookLoginProvider>(context,
                      listen: false).result!.accessToken!.userId;
                  email = Provider.of<FacebookLoginProvider>(context,
                      listen: false).userData!['email'];
                  fullName = Provider.of<FacebookLoginProvider>(context,
                      listen: false).userData!['name'];

                  Provider.of<AuthProvider>(context,listen: false).getToken();
                  socialLogin.uuiId = id;
                  socialLogin.email = email;
                  socialLogin.tokenId = Provider.of<AuthProvider>(context,
                      listen: false).token ?? "";
                  socialLogin.fullName = fullName;
                  socialLogin.clientName = fullName;
                  socialLogin.mobile = "";
                  socialLogin.address = "";
                  await Provider.of<AuthProvider>(context,
                      listen: false).socialLogin(socialLogin,3,route);
                }
              },
              child: Ink(
                color: Color(0xFF397AF3),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(height: 25,width: 25,
                              child: Image.asset(Images.facebook)), // <-- Use 'Image.asset(...)' here
                          SizedBox(width: 5),
                          Text('Facebook',style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  route(bool isRoute,String message) async {
    if (isRoute) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
    }
    else {
      showCustomSnackBar(message,context);
    }
  }
}