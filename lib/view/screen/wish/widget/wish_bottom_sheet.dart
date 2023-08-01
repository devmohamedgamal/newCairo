import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/wish_model.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/items_cart_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../baseWidget/button/custom_button.dart';
import '../../../baseWidget/show_custom_snakbar.dart';

class WishBottomSheet extends StatefulWidget {
  final Wish wish;
  final Function()? callback;
  WishBottomSheet({required this.wish, this.callback});
  @override
  _WishBottomSheetState createState() => _WishBottomSheetState();
}
class _WishBottomSheetState extends State<WishBottomSheet> {

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context,
        listen: false).getDetailsProduct(context,
        Provider.of<AuthProvider>(context, listen: false).user == null
            ? ""
            : Provider.of<AuthProvider>(context, listen: false).user!.userId!,
        widget.wish.productId!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Consumer<ProductProvider>(
            builder: (context, details, child) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Close Button
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).highlightColor, boxShadow: [BoxShadow(
                      color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200]!,
                      spreadRadius: 1,
                      blurRadius: 5,
                    )]),
                    child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
                  ),
                )),

                // Product details
                Row(children: [
                  Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: ColorResources.getImageBg(context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      image: '${AppConstants.BASE_URL_IMAGE}${widget.wish.pavatar}',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                          ? widget.wish.titleEN ?? ''
                          : widget.wish.title ?? '',
                          style: cairoSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE), maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Text(widget.wish.price! + " \$",
                        style: cairoBold.copyWith(color: ColorResources.getPrimary(context), fontSize: 16),
                      ),
                      double.parse(widget.wish.priceBefore!) > 0
                          ? Text(widget.wish.price! + " \$",
                        style: cairoRegular.copyWith(
                            color: Theme.of(context).hintColor,
                            decoration: TextDecoration.lineThrough),
                      ) : SizedBox(),
                    ]),
                  ),
                ]),

                // Quantity
                Row(children: [
                  Text(getTranslated('quantity', context)!,
                      style: cairoBold),
                  QuantityButton(
                      isIncrement: false, quantity: details.quantity),
                  Text(details.quantity.toString(), style: cairoSemiBold),
                  QuantityButton(
                      isIncrement: true, quantity: details.quantity),
                ]),

                // Variant
                details.detailsProduct == null ||
                    details.detailsProduct!.fetchedProductSize!.isEmpty
                    ? SizedBox()
                    : Container(
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: ColorResources.WHITE,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(getTranslated("product_variants", context)!,
                            style: cairoBold),

                        Column(
                          children: details.detailsProduct!.fetchedProductSize!
                              .keys.map((key) => Padding(
                            padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                key.contains("#")
                                    ? Row(
                                  children: [
                                    Text(getTranslated("color_variants", context)! +
                                        key.toString(),
                                        style: cairoBold),

                                    Container(
                                      width: 25,
                                      height: 25,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(50),
                                          color: Colors.grey),
                                      child: Center(
                                        child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Color(
                                                    int.parse("0xfff${key.toString().replaceAll("#","")}")))),
                                      ),
                                    )
                                  ],
                                )
                                    : Text(getTranslated("variants", context)! + key.toString(),
                                    textAlign: TextAlign.right,
                                    style: cairoBold),

                                Column(
                                    children: details.detailsProduct!.
                                    fetchedProductSize![key]!.map((item) => Padding(
                                        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                        child: Container(
                                            margin: EdgeInsets.zero,
                                            padding: EdgeInsets.fromLTRB(5,0,5,0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(0),
                                                color: Colors.black.withOpacity(0.05)),
                                            child: ListTile(
                                              onTap: () {
                                                if(details.selectVariant != null &&
                                                    details.selectVariant!.id == item.id){
                                                  details.removeVariant(item.id!);
                                                }
                                                else{
                                                  details.addVariant(item);
                                                }
                                              },
                                              title: Text(item.color == null || item.color!.isEmpty
                                                  ? "??"
                                                  : item.color.toString(),
                                                  style: cairoBold),
                                              subtitle: Row(
                                                children: [
                                                  Text(getTranslated("product_price", context)! + " :  ",
                                                      style: cairoBold),

                                                  Text(item.price! + " \$",
                                                      style: cairoBold.copyWith(color: Colors.black)),
                                                ],
                                              ),
                                              trailing: Checkbox(
                                                value: details.selectVariant != null &&
                                                    details.selectVariant!.id == item.id,
                                                onChanged: (bool? value) {},
                                                activeColor: ColorResources.DEFAULT_COLOR,
                                              ),
                                            )
                                        )
                                    )
                                    ).toList()
                                )
                              ],
                            ),
                          )
                          ).toList(),
                        )
                      ],
                    )),

                Row(children: [
                  Text(getTranslated('total_price', context)!,
                      style: cairoBold),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Text(
                    PriceConverter.calculateTotal(
                        context,
                        details.selectVariant != null
                            ? (details.selectVariant!.price ?? "0.0").replaceAll(",","")
                            : (widget.wish.price ?? "0.0").replaceAll(",",""),
                        details.quantity) + " \$",
                    style: cairoBold.copyWith(
                        color: ColorResources.getPrimary(context),
                        fontSize: 16),
                  ),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                // Cart button
                Provider.of<CartProvider>(context).isLoading
                    ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                )
                    : CustomButton(
                    buttonText: getTranslated('add_to_cart', context)!,
                    onTap: () async {
                      if(details.selectVariant != null) {
                        int? check = await Provider.of<CartProvider>(context,
                            listen: false).isAddedInCart(
                            widget.wish.productId,details.selectVariant!.id);
                        if(check == -1) {
                          ItemsCartModel cart = ItemsCartModel(
                            widget.wish.productId,
                            widget.wish.pavatar,
                            widget.wish.title,
                            widget.wish.titleEN,
                            double.parse(
                                details.selectVariant!.price ?? "0.0"),
                            details.quantity,
                            int.parse(details.selectVariant!.qnt!.isEmpty
                                ? "0"
                                : details.selectVariant!.qnt ?? "0"),
                            details.selectVariant!.id!,
                            details.selectVariant!.color ?? "",
                          );
                          Provider.of<CartProvider>(context,listen: false).addToCart(cart);
                          Navigator.pop(context);
                          showCustomSnackBar(
                              getTranslated('added_to_cart', context)!,
                              context, isError: false);
                        }
                        else {
                          showCustomSnackBar(
                              getTranslated('already_added', context)!,
                              context);
                        }
                      }
                      else{
                        showCustomSnackBar(
                            getTranslated('must_choose_variants', context)!,
                            context);
                      }
                    }),
              ]);
            },
          ),
        ),
      ],),
    );
  }

  route(bool isRoute,String message) async {
    if (isRoute) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
    }
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final bool isCartWidget;

  QuantityButton({
    required this.isIncrement,
    required this.quantity,
    this.isCartWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!isIncrement && quantity > 1) {
          Provider.of<ProductProvider>(context, listen: false)
              .setQuantity(quantity - 1);
        } else if (isIncrement) {
          Provider.of<ProductProvider>(context, listen: false)
              .setQuantity(quantity + 1);
        }
      },
      icon: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? ColorResources.getPrimary(context)
            : quantity > 1
            ? ColorResources.getPrimary(context)
            : ColorResources.getLowGreen(context),
        size: isCartWidget ? 26 : 20,
      ),
    );
  }
}