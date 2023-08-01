import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/wish_model.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/wish/widget/wish_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../baseWidget/show_custom_snakbar.dart';

class WishListWidget extends StatelessWidget {
  final Wish wish;
  final int index;
  WishListWidget({required this.wish,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            FadeInImage.assetNetwork(
              placeholder: Images.placeholder, fit: BoxFit.scaleDown,
              width: 55, height: 55,
              image: '${AppConstants.BASE_URL_IMAGE}${wish.pavatar}',
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                  fit: BoxFit.scaleDown, width: 55, height: 55),
            ),

            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                              ? wish.titleEN ?? ""
                              : wish.title ?? "",
                          style: cairoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            color: ColorResources.getPrimary(context),
                          ),
                        ),
                      ),

                      CircleAvatar(
                        backgroundColor: Theme.of(context).hintColor,
                        radius: 10,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.center,
                          icon: Icon(Icons.delete_forever,
                              color: ColorResources.getRed(context),
                              size: 10),
                          onPressed: () {
                            showDialog(context: context, builder: (_) => CupertinoAlertDialog(
                              title: Text(
                                  getTranslated('ARE_YOU_SURE_WANT_TO_REMOVE_WISH_LIST',
                                      context)!),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(getTranslated('YES', context)!),
                                  onPressed: () {
                                    Provider.of<WishProvider>(context,
                                        listen: false).removeWishList(
                                        context,wish.customerId!,
                                        wish.id!,index: index,
                                        callback: feedbackMessage);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(getTranslated('NO', context)!),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(
                    children: [
                      Text(wish.price! + " \$",
                        style: cairoSemiBold.copyWith(
                            color: ColorResources.getPrimary(context)),
                      ),
                      Expanded(
                        child: Text(
                          '${wish.quantity ?? "1"} x',
                          style: cairoSemiBold.copyWith(
                              color: ColorResources.getPrimary(context)),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: ColorResources.getPrimary(context))),
                        child: Text(wish.priceBefore! + " \$",
                          style: cairoRegular.copyWith(
                              decoration: TextDecoration.lineThrough,
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: ColorResources.getPrimary(context)),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Provider.of<ProductProvider>(context, listen: false)
                              .setQuantity(1);
                          showModalBottomSheet(context: context, isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (con) => WishBottomSheet(wish: wish));
                        },
                        child: Container(
                          height: 20,
                          margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor,
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart, color: Colors.white, size: 10),
                              FittedBox(
                                child: Text(getTranslated('add_to_cart', context)!,
                                    style: cairoBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  feedbackMessage(bool status,String message,BuildContext context) {
    showCustomSnackBar(message,context, isError: !status);
  }
}
