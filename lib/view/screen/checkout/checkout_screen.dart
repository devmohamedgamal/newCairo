import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/cart_model.dart';
import 'package:lemirageelevators/data/model/response/items_cart_model.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import 'package:lemirageelevators/provider/cart_provider.dart';
import 'package:lemirageelevators/provider/coupon_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/no_items_cart_widget.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:lemirageelevators/view/screen/checkout/widget/address_bottom_sheet.dart';
import 'package:lemirageelevators/view/screen/checkout/widget/custom_check_box.dart';
import 'package:lemirageelevators/view/screen/checkout/widget/shipping_method_bottom_sheet.dart';
import 'package:lemirageelevators/view/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/localization_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../baseWidget/amount_widget.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/textfield/custom_textfield.dart';
import '../../baseWidget/title_row.dart';
import '../cart/cart_screen.dart';
import '../payment/choose_payment_screen.dart';
import 'dart:io';
import '../../../provider/auth_provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<ItemsCartModel> cartList;
  // final double totalOrderAmount;
  // final double shippingCost;
  // final int shippingIndex;

  CheckoutScreen({
    required this.cartList,
    // required this.totalOrderAmount,
    // required this.shippingIndex,
    // required this.shippingCost,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  TextEditingController? _noteController = TextEditingController();
  TextEditingController _couponController = TextEditingController();

  double _getTotalAmount(BuildContext context) {
    return PriceConverter.convertWithDiscount(
      discount: Provider.of<CouponProvider>(context, listen: true).discountPercentage,
      price: Provider.of<CartProvider>(context).amount,
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    Provider.of<ProfileProvider>(context, listen: false).getAddress();
  }

  Future<void> _paymentOnCashPlaceOrder({
    required String note,
  }) async {
    // items
    List<CartItem>? _items = [];
    Provider.of<CartProvider>(context, listen: false).cartList.forEach((item) {
      _items.add(CartItem(
        int.parse(item.variantId!),
        int.parse(item.id!),
        int.parse(item.quantity.toString()),
      ));
    });

    // client Id
    String clientId = await Provider.of<AuthProvider>(context, listen: false).user!.userId!;

    // mobile
    String mobile = await Provider.of<AuthProvider>(context, listen: false).user!.mobile!;

    // address City
    String addressCity = await Provider.of<ProfileProvider>(context, listen: false)
        .addressList[Provider.of<ProfileProvider>(context, listen: false).addressIndex!]
        .city!;

    // full Address
    String fullAddress = Provider.of<ProfileProvider>(context, listen: false)
        .addressList[Provider.of<ProfileProvider>(context, listen: false).addressIndex!]
        .address
        .toString();

    // type Address is home || office
    String typeAddress = await Provider.of<ProfileProvider>(context, listen: false)
        .addressList[Provider.of<ProfileProvider>(context, listen: false).addressIndex!]
        .addressType!;

    // shipping id
    String shipping = await Provider.of<CartProvider>(context, listen: false)
        .shippingPlacesList[Provider.of<CartProvider>(context, listen: false).shippingPlacesIndex ?? 0]
        .id
        .toString();

    String amount = Provider.of<CartProvider>(context, listen: false).amount.toString();

    int? indexTypeCashApp = Provider.of<CartProvider>(context, listen: false).indexType;

    Provider.of<OrderProvider>(context, listen: false).placeOrder(
      CartModel(
          int.parse(clientId),
          note,
          mobile,
          addressCity,
          null,
          indexTypeCashApp, //1 google pay 2 apple pay 3 credit card
          fullAddress,
          typeAddress,
          int.tryParse(shipping)??-1,
          _items,
          PriceConverter.convertWithDiscount(
            discount: Provider.of<CouponProvider>(context, listen: false).discountPercentage,
            price: Provider.of<CartProvider>(context, listen: false).amount,
          ).toString(),
          Platform.isAndroid ? "Android" : "Iphone",
          null,
          null,
          null,
          null,
          null),
      _route,
      PaymentMethod: 3,
    );
  }

  _route(bool status, String? _, String message) async {
    showCustomSnackBar(message, context, isError: !status);

    if (status) {
      // Navigator.pop(context);
      // clear cart items
      Provider.of<CartProvider>(context, listen: false).clearCart();
      // todo: navigate to success order screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => DashBoardScreen()),
        (route) => true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('checkout', context)),
          Expanded(
            child: Provider.of<CartProvider>(context).cartList.isEmpty ? NoItemsCartWidget() : ListView(physics: BouncingScrollPhysics(), padding: EdgeInsets.all(0), children: [
              // Shipping Details
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                child: Column(children: [
                  InkWell(
                    onTap: () => showModalBottomSheet(
                        context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => AddressBottomSheet()),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(getTranslated('SHIPPING_TO', context), style: cairoRegular),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(
                          Provider.of<ProfileProvider>(context).addressIndex == null
                              ? getTranslated('add_your_address', context)
                              : Provider.of<ProfileProvider>(context, listen: false)
                                  .addressList[Provider.of<ProfileProvider>(context, listen: false).addressIndex!]
                                  .address!,
                          style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Image.asset(Images.EDIT_TWO, width: 15, height: 15, color: ColorResources.getPrimary(context)),
                      ]),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Divider(height: 2, color: ColorResources.getHint(context)),
                  ),
                  InkWell(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          ShippingMethodBottomSheet(index: Provider.of<CartProvider>(context, listen: false).shippingPlacesIndex ?? 0),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('shipping_address'.tr(context), style: cairoRegular),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(
                          Provider.of<CartProvider>(context).selectedShippingArea == null
                              ? 'select_a_shipping_address'.tr(context)
                              : Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                              ? '${Provider.of<CartProvider>(context, listen: false).selectedShippingArea?.nameEn}'
                              : '${Provider.of<CartProvider>(context, listen: false).selectedShippingArea?.nameAr}',
                          style: cairoSemiBold.copyWith(
                            color: ColorResources.getPrimary(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Image.asset(Images.EDIT_TWO, width: 15, height: 15, color: ColorResources.getPrimary(context)),
                      ]),
                    ]),
                  ),
                ]),
              ),

              // Order Details
              Container(
                margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).highlightColor,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TitleRow(
                      title: getTranslated('ORDER_DETAILS', context),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                      }),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Row(children: [
                      FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        image: '${AppConstants.BASE_URL_IMAGE}${widget.cartList[0].image}',
                        imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover, width: 50, height: 50),
                      ),
                      SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
                      Expanded(
                        flex: 3,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                ? widget.cartList[0].titleEn!
                                : widget.cartList[0].title!,
                            style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: ColorResources.getPrimary(context)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                          Row(children: [
                            Text(
                              widget.cartList[0].price.toString() + " ${getTranslated('currency', context)}",
                              style: cairoSemiBold.copyWith(color: ColorResources.getPrimary(context)),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                            Text(widget.cartList[0].quantity.toString() + "x",
                                style: cairoSemiBold.copyWith(color: ColorResources.getPrimary(context))),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                            Container(
                              height: 20,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16), border: Border.all(color: ColorResources.getPrimary(context))),
                              child: Text(
                                PriceConverter.calculateTotal(context, widget.cartList[0].price.toString(), widget.cartList[0].quantity!) + " ${getTranslated('currency', context)}",
                                style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: ColorResources.getPrimary(context)),
                              ),
                            ),
                          ]),
                        ]),
                      ),
                    ]),
                  ),
                ]),
              ),

              // Total bill
              Container(
                margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).highlightColor,
                child: Consumer<OrderProvider>(
                  builder: (context, order, child) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      TitleRow(title: getTranslated('TOTAL', context)),
                      AmountWidget(
                          title: getTranslated('ORDER', context), amount: (Provider.of<CartProvider>(context).amount - Provider.of<CartProvider>(context).shippingPrice).toString() + " ${getTranslated('currency', context)}"),
                      AmountWidget(title: getTranslated('SHIPPING_FEE', context), amount: Provider.of<CartProvider>(context).shippingPrice.toString() + " ${getTranslated('currency', context)}"),
                      AmountWidget(title: getTranslated('promo_code', context), amount: '(-) ${PriceConverter.getDiscountPercentageAmount(discount: Provider.of<CouponProvider>(context).discountPercentage, price: Provider.of<CartProvider>(context).shippingPrice)}' " ${getTranslated('currency', context)}"),
                      Divider(height: 5, color: Theme.of(context).hintColor),
                      AmountWidget(title: getTranslated('TOTAL_PAYABLE', context), amount: _getTotalAmount(context).toString() + " ${getTranslated('currency', context)}"),
                    ]);
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).highlightColor,
                child: Consumer<CouponProvider>(
                  builder: (context, couponProvider, _) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      TitleRow(title: getTranslated('promo_code', context)),
                        HSpacer(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                            border: Border.all(color: Theme.of(context).primaryColor),
                          ),
                          child: Row(children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _couponController,
                                  decoration: InputDecoration(
                                    hintText: getTranslated('enter_promo_code', context),
                                    hintStyle: cairoRegular.copyWith(color: Theme.of(context).hintColor),
                                    isDense: true,
                                    filled: true,
                                    enabled: couponProvider.coupon == null,
                                    fillColor: Theme.of(context).cardColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 10 : 0),
                                        right: Radius.circular(Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 0 : 10),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // apply coupon button
                            InkWell(
                              onTap: () async {
                                final _couponCode = _couponController.text.trim();
                                if(couponProvider.coupon != null){
                                  couponProvider.removeCouponData(true);
                                  _couponController.clear();
                                } else if(_couponCode.isEmpty) {
                                  showCustomSnackBar('enter_promo_code'.tr(context), context);
                                } else if(!couponProvider.isLoading) {
                                  // implement appling code
                                  await couponProvider.checkCoupon(_couponCode, context);
                                  if(couponProvider.coupon != null){
                                    showCustomSnackBar(
                                              '${'you_got_discount_of'.tr(context)} ${couponProvider.discountPercentage}%',
                                              context,
                                      isError: false,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 50, width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  // boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 0 : 10),
                                    right: Radius.circular(Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 10 : 0),
                                  ),
                                ),
                                child: couponProvider.isLoading
                                            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                                            : (couponProvider.coupon != null)
                                                ? Icon(Icons.clear, color: Colors.white)
                                                : Text(
                                                    'APPLY'.tr(context),
                                                    style: cairoMedium.copyWith(color: Theme.of(context).cardColor),
                                                  ),
                                      ),
                            ),
                          ],
                          ),
                        ),
                    ],
                    );
                  },
                ),
              ),

              // Payment Method
              Container(
                margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).highlightColor,
                child: Column(children: [
                  TitleRow(title: getTranslated('payment_method', context)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  CustomCheckBox(
                    title: getTranslated('cash_on_delivery', context),
                    index: 1,
                  ),
                  CustomCheckBox(
                    title: getTranslated('digital_payment', context),
                    index: 0,
                  ),
                ]),
              ),

              // note
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(getTranslated('Responsible_Person', context), style: cairoRegular),
                    Image.asset(Images.EDIT_TWO, width: 15, height: 15, color: ColorResources.getPrimary(context)),
                  ]),
                  CustomTextField(
                    hintText: getTranslated('Responsible_Person', context),
                    controller: _noteController,
                    maxLine: 3,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Divider(height: 2, color: ColorResources.getHint(context)),
                  ),
                ]),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            color: ColorResources.getPrimary(context), borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: Consumer<OrderProvider>(
          builder: (context, order, child) {
            return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                getTranslated('TOTAL', context) + " " + _getTotalAmount(context).toString() + " ${getTranslated('currency', context)}",
                style: cairoSemiBold.copyWith(color: Theme.of(context).highlightColor),
              ),
              !Provider.of<OrderProvider>(context).isLoading
                  ? TextButton(
                      onPressed: () async {
                        if (Provider.of<ProfileProvider>(context, listen: false).addressIndex == null) {
                          showCustomSnackBar(getTranslated('select_a_shipping_address', context), context);
                        } else if (Provider.of<CartProvider>(context, listen: false).shippingPlacesIndex == null) {
                          showCustomSnackBar(getTranslated('select_a_shipping_address', context), context);
                        } else if (Provider.of<OrderProvider>(context, listen: false).paymentMethodIndex == 1) {
                          _paymentOnCashPlaceOrder(note: _noteController?.text??'');
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosePaymentScreen(note: _noteController!.text.toString())));
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        backgroundColor: Theme.of(context).highlightColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(getTranslated('proceed', context),
                          style: cairoSemiBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            color: ColorResources.getPrimary(context),
                          )),
                    )
                  : Container(
                      height: 30,
                      width: 100,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).highlightColor)),
                    ),
            ]);
          },
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String image;
  final Function()? onTap;

  PaymentButton({required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: ColorResources.getGrey(context)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
