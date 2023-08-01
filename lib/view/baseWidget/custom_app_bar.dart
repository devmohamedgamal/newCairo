import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final isBackButtonExist;
  final IconData? icon;
  final Function()? onActionPressed;
  final Function()? onBackPressed;

  CustomAppBar({required this.title, this.isBackButtonExist = true,
    this.icon, this.onActionPressed, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
        child: Image.asset(
          Images.toolbar_background,
          fit: BoxFit.fill,
          height: 50+MediaQuery.of(context).padding.top, width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : null,
        ),
      ),

      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [
          isBackButtonExist
              ? IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
            onPressed: () => onBackPressed != null
                ? onBackPressed!
                : Navigator.of(context).pop(),
          )
              : SizedBox.shrink(),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

          Expanded(
            child: Text(
              title, style: cairoRegular.copyWith(fontSize: 20, color: Colors.white),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
          ),

          icon != null
              ? IconButton(
            icon: Icon(icon, size: Dimensions.ICON_SIZE_LARGE, color: Colors.white),
            onPressed: onActionPressed,
          )
              : SizedBox.shrink(),

        ]),
      ),
    ]);
  }
}