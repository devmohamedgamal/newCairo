import 'package:flutter/material.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/home_model.dart';
import '../../../../data/model/response/items_cart_model.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/textStyle.dart';
import '../../../baseWidget/button/custom_button.dart';
import '../../../baseWidget/show_custom_snakbar.dart';

class CartBottomSheet extends StatefulWidget {
  final Product product;
  CartBottomSheet({required this.product});
  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}
class _CartBottomSheetState extends State<CartBottomSheet> {
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
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Consumer<ProductProvider>(
              builder: (context, details, child) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Close Button
                      Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).highlightColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[
                                      Provider.of<ThemeProvider>(context)
                                          .darkTheme
                                          ? 700
                                          : 200]!,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ]),
                              child: Icon(Icons.clear,
                                  size: Dimensions.ICON_SIZE_SMALL),
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
                            image:
                            '${AppConstants.BASE_URL_IMAGE}${widget.product.pavatar}',
                            imageErrorBuilder: (c, o, s) =>
                                Image.asset(Images.placeholder),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                    ? widget.product.titleEn ?? ''
                                    : widget.product.title ?? '',
                                    style: cairoSemiBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                  widget.product.price.toString() + " \$",
                                  style: cairoBold.copyWith(
                                      color: ColorResources.getPrimary(context),
                                      fontSize: 16),
                                ),
                                double.parse(
                                    (widget.product.priceBefore ?? "0.0").replaceAll(",","")) >
                                    0
                                    ? Text(
                                  widget.product.priceBefore.toString() + " \$",
                                  style: cairoRegular.copyWith(
                                      color: Theme.of(context).hintColor,
                                      decoration:
                                      TextDecoration.lineThrough),
                                )
                                    : SizedBox(),
                              ]),
                        ),
                        Expanded(child: SizedBox.shrink()),
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
                      details.detailsProduct == null || details.detailsProduct!.fetchedProductSize!.isEmpty
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
                                children: (Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                    ? details.detailsProduct!.fetchedProductSizeEN!
                                    : details.detailsProduct!.fetchedProductSize!)
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
                                          children: (Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                              ? details.detailsProduct!.fetchedProductSizeEN!
                                              : details.detailsProduct!.fetchedProductSize!)[key]!.map((item) => Padding(
                                              padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                              child: Container(
                                                  margin: EdgeInsets.zero,
                                                  padding: EdgeInsets.fromLTRB(5,0,5,0),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(0),
                                                      color: Colors.black.withOpacity(0.05)),
                                                  child: CheckboxListTile(
                                                    title: Text(item.color == null || item.color!.isEmpty
                                                        ? " "
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
                                                    activeColor: ColorResources.DEFAULT_COLOR,
                                                    value: details.selectVariant != null &&
                                                        details.selectVariant!.id == item.id,
                                                    onChanged: (bool? value) {
                                                      if(details.selectVariant != null &&
                                                          details.selectVariant!.id == item.id){
                                                        details.removeVariant(item.id!);
                                                      }
                                                      else{
                                                        details.addVariant(item);
                                                      }
                                                    },
                                                  ),
                                              ),
                                          ),
                                          ).toList()
                                      ),
                                    ],
                                  ),
                                ),
                                ).toList(),
                              ),
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
                                  : (widget.product.price ?? "0.0").replaceAll(",",""),
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
                                  widget.product.id,details.selectVariant!.id);
                              if(check == -1) {
                                ItemsCartModel cart = ItemsCartModel(
                                  widget.product.id,
                                  widget.product.pavatar,
                                  widget.product.title,
                                  widget.product.titleEn,
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
                                showCustomSnackBar(getTranslated('added_to_cart', context)!,
                                    context, isError: false);
                              }
                              else {
                                showCustomSnackBar(getTranslated('already_added', context)!,context);
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
        ],
      ),
    );
  }

  route(bool isRoute, String message) async {
    if (isRoute) {
      showCustomSnackBar(message, context,isError: false);
      Navigator.pop(context);
    }
    else {
      Navigator.pop(context);
      showCustomSnackBar(message, context,isError: false);
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