import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/coupon_provider.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/no_items_cart_widget.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:lemirageelevators/view/screen/cart/widget/cart_widget.dart';
import 'package:lemirageelevators/view/screen/cart/widget/suggested_products_widget.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/localization_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/dialog/animated_custom_dialog.dart';
import '../../baseWidget/dialog/guest_dialog.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../checkout/checkout_screen.dart';
import '../checkout/widget/shipping_method_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  final bool isBacButtonExist;
  CartScreen({this.isBacButtonExist = true});
  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<CartProvider>(context, listen: false).getCartData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CouponProvider>(context, listen: false).removeCouponData(true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      return Scaffold(
        body: Column(children: [
          CustomAppBar(
              title: getTranslated('CART', context),
          isBackButtonExist: widget.isBacButtonExist),

          cart.cartList.length == 0
              ? Expanded(
                  child: NoItemsCartWidget(),
          )
              : Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.cartList.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: Dimensions.PADDING_SIZE_SMALL),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3)),
                                ]),
                            child: CartWidget(
                              itemsCartModel: cart.cartList[index],
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // suggested products
                  SuggestedProductsWidget(),

                  Provider.of<CartProvider>(context,
                      listen: false).shippingPlacesList.isNotEmpty
                      ? InkWell(
                    onTap: () {
                      if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                        showModalBottomSheet(
                          context: context, isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => ShippingMethodBottomSheet(
                              index: cart.shippingPlacesIndex ?? 0),
                        );
                      }
                      else {
                        showAnimatedDialog(
                          context,
                          GuestDialog(),
                          isFlip: true,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5,color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('shipping_address'.tr(context), style: cairoRegular),
                          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Text(
                              cart.selectedShippingArea == null
                                  ? 'select_a_shipping_address'.tr(context)
                                  : Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                    ? '${cart.selectedShippingArea?.nameEn}'
                                    : '${cart.selectedShippingArea?.nameAr}',
                              style: cairoSemiBold.copyWith(
                                  color: ColorResources.getPrimary(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Theme.of(context).primaryColor,
                            ),
                          ]),
                        ]),
                      ),
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            ),
          )
        ]),

        bottomNavigationBar: cart.cartList.length != 0
            ? Container(
                height: 60,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: ColorResources.getPrimary(context),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children: [
                            Text(
                              getTranslated("TOTAL", context),
                              style: cairoSemiBold.copyWith(
                                  color: Theme.of(context).highlightColor),
                            ),

                            WSpacer(5),
                            Text(
                              cart.amount.toString() + " ${getTranslated('currency', context)}",
                              textDirection: TextDirection.ltr,
                              style: cairoSemiBold.copyWith(
                                  color: Theme.of(context).highlightColor),
                            ),
                          ],
                        ),

                      TextButton(
                          onPressed: () {
                            if (Provider.of<AuthProvider>(context,listen: false).isLoggedIn()) {
                              if (cart.cartList.length == 0) {
                                showCustomSnackBar(
                                    getTranslated('select_at_least_one_product', context),
                                    context, isError: false);
                              }
                              else {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (_) => CheckoutScreen(
                                  cartList: cart.cartList,
                                  // shippingIndex: Provider.of<CartProvider>(context,
                                  //     listen: false).shippingPlacesIndex ?? -1,
                                  // totalOrderAmount: cart.amount,
                                  // shippingCost: cart.shippingPrice,
                                )));
                              }
                            }
                            else {
                              showAnimatedDialog(
                                context,
                                GuestDialog(),
                                  isFlip: true,
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(5),
                            backgroundColor: Theme.of(context).highlightColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Center(
                            child: Text(getTranslated('checkout', context)!,
                                textAlign: TextAlign.center,
                                style: cairoSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  color: ColorResources.getPrimary(context),
                                )),
                          )
                      )
                    ]),
              )
            : null,
      );
    });
  }
}