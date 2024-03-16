import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/provider/theme_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/dimensions.dart';
import 'package:lemirageelevators/util/images.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:lemirageelevators/view/screen/auth/widget/sign_in_widget.dart';
import 'package:lemirageelevators/view/screen/auth/widget/sign_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  final int initialPage;
  AuthScreen({this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    PageController _pageController = PageController(initialPage: initialPage);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // background
          Provider.of<ThemeProvider>(context).darkTheme
              ? SizedBox()
              : Image.asset(Images.background_auth,
                  fit: BoxFit.fill,
                  height: height(context),
                  width: width(context)),

          Consumer<AuthProvider>(
            builder: (context, auth, child) => SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HSpacer(20),

                  // for logo with text
                  Image.asset(Images.logo, height: 150, width: 200),

                  // for decision making section like signin or register section
                  Padding(
                    padding: EdgeInsets.only(
                      top: Dimensions.MARGIN_SIZE_LARGE,
                      left: Dimensions.MARGIN_SIZE_LARGE,
                      right: Dimensions.MARGIN_SIZE_LARGE,
                      bottom: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: 0,
                          right: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          left: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                right: Dimensions.FONT_SIZE_LARGE),
                            height: 1,
                            color: ColorResources.getGainsBoro(context),
                          ),
                        ),
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) => Row(
                            children: [
                              InkWell(
                                onTap: () => _pageController.animateToPage(0,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut),
                                child: Column(
                                  children: [
                                    Text(getTranslated('SIGN_IN', context)!,
                                        style: authProvider.selectedIndex == 0
                                            ? cairoSemiBold
                                            : cairoRegular),
                                    Container(
                                      height: 1,
                                      width: 60,
                                      margin: EdgeInsets.only(top: 8),
                                      color: authProvider.selectedIndex == 0
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                              WSpacer(30),
                              InkWell(
                                onTap: () => _pageController.animateToPage(1,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut),
                                child: Column(
                                  children: [
                                    Text(getTranslated('SIGN_UP', context)!,
                                        style: authProvider.selectedIndex == 1
                                            ? cairoSemiBold
                                            : cairoRegular),
                                    Container(
                                        height: 1,
                                        width: 50,
                                        margin: EdgeInsets.only(top: 8),
                                        color: authProvider.selectedIndex == 1
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // show login or register widget
                  Expanded(
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) =>
                          PageView.builder(
                        itemCount: 2,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          if (authProvider.selectedIndex == 0) {
                            return SignInWidget();
                          } else {
                            return SignUpWidget();
                          }
                        },
                        onPageChanged: (index) {
                          authProvider.updateSelectedIndex(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
