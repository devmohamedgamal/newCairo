import 'package:flutter/material.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/util/images.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';

class NoItemsCartWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(Images.cart_image,
            width: width(context) * 0.5,
            height: height(context) * 0.1),
        HSpacer(15),
        Text(
          getTranslated("no_products_cart", context),
          style: cairoSemiBold,
        ),
      ],
    );
  }
}
