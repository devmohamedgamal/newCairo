import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../provider/theme_provider.dart';
import '../../util/color_resources.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../../util/responsive.dart';
import 'not_loggedin_widget.dart';

class CustomExpandedAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomChild;
  final bool isGuestCheck;
  CustomExpandedAppBar({required this.title,required this.child, this.bottomChild, this.isGuestCheck = false});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    return Scaffold(
      floatingActionButton: isGuestCheck ? isGuestMode ? null : bottomChild : bottomChild,
      body: Stack(children: [

        // Background
        Image.asset(
          Images.more_page_header,
          height: 110, fit: BoxFit.fill,
          width: width(context),
          color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : null,
        ),

        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Row(children: [
            CupertinoNavigationBarBackButton(color: Colors.white, onPressed: () {
              Navigator.pop(context);
            }),
            Text(title, style: cairoRegular.copyWith(
                fontSize: 20, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: EdgeInsets.only(top: 95),
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: isGuestCheck ? isGuestMode ? NotLoggedInWidget() : child : child,
        ),
      ]),
    );
  }
}
