import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/home_model.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../cart/cart_screen.dart';
import 'cart_bottom_sheet.dart';

class BottomCartView extends StatelessWidget {
  final Product product;
  BottomCartView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300]!,
            blurRadius: 15, spreadRadius: 1)],
      ),
      child: Row(children: [
        Expanded(flex: 3,
            child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Stack(children: [
            // ICON BASKET
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CartScreen()
                  ));
                },
                child: Image.asset(Images.cart_image,
                    color: ColorResources.getPrimary(context))),

            // COUNTER
            Positioned(
              top: 0,
              right: 5,
              child: Container(
                height: 17,
                width: 17,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.getPrimary(context),
                ),
                child: Text(Provider.of<CartProvider>(context).cartList.length.toString(),
                  style: cairoSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      color:Theme.of(context).highlightColor),
                ),
              ),
            )
          ]),
        )),

        Expanded(flex: 11,
            child: InkWell(
          onTap: () {
            Provider.of<ProductProvider>(context, listen: false)
                .setQuantity(1);
            showModalBottomSheet(context: context,
                isScrollControlled: true, backgroundColor: Colors.transparent,
                builder: (con) => CartBottomSheet(product: product),
              useSafeArea: true,
            );
          },
              child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.getPrimary(context),
            ),
            child: Text(
              getTranslated('add_to_cart', context)!,
              style: cairoSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: Theme.of(context).highlightColor),
            ),
          ),
        )),
      ]),
    );
  }
}