import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/payment_model.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import 'package:lemirageelevators/provider/coupon_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/view/baseWidget/button/custom_button.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/cart_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/web_view_screen.dart';

class ChoosePaymentScreen extends StatefulWidget {
  final String note;

  const ChoosePaymentScreen({required this.note});

  @override
  _ChoosePaymentScreenState createState() => _ChoosePaymentScreenState();
}

class _ChoosePaymentScreenState extends State<ChoosePaymentScreen> {
  int typePayment = 0;

  void _selectPaymentMethod(BuildContext context, PaymentModel paymentModel){
    Provider.of<OrderProvider>(context, listen: false).selectPaymentMethod(paymentModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('choose_payment_method', context)),
          Expanded(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.payment),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Consumer<OrderProvider>(
                builder: (context, orderProvider, _){
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                      mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    itemCount: AppConstants.paymentMethods.length,
                    itemBuilder: (context, index){
                      final paymentModel = AppConstants.paymentMethods[index];
                      final isSelected = paymentModel == orderProvider.selectedPaymentModel;

                      return InkWell(
                        onTap: (){
                          _selectPaymentMethod(context, paymentModel);
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(paymentModel.assetImagePath),
                                    fit: BoxFit.contain,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 5,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: isSelected ? Border.all(
                                    color: ColorResources.DEFAULT_COLOR,
                                    width: 4,
                                  ) : null,
                                ),
                              ),
                            ),
                            Text(
                              paymentModel.nameTrKey,
                              style: isSelected
                                  ? cairoBold.copyWith(
                                      color: ColorResources.DEFAULT_COLOR,
                                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                    )
                                  : cairoSemiBold,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Consumer<OrderProvider>(
            builder: (context, orderProvider, _){
              return CustomButton(
                onTap: orderProvider.isPaymentMethodSelected ? () async {
                  await _paymentPlaceOrder(
                    type: null,
                    note: widget.note,
                    paymentModel: Provider.of<OrderProvider>(context, listen: false).selectedPaymentModel!,
                  );
                } : null,
                buttonText: getTranslated("NEXT", context),
              );
            },
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget typePaymentWidget({required String title, required bool value, String? image, required Function onChanged}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: CheckboxListTile(
          title: Row(
            children: [image == null ? Container() : Image.asset(image, width: 30, height: 50), WSpacer(8), Text(title)],
          ),
          activeColor: Colors.teal,
          contentPadding: EdgeInsets.all(5),
          controlAffinity: ListTileControlAffinity.leading,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorResources.BLACK.withOpacity(0.1), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          value: value,
          onChanged: (v) {
            onChanged();
          }),
    );
  }

  Future<void> _paymentPlaceOrder({
    int? type,
    required String note,
    required PaymentModel paymentModel,
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
    String addressCity = await Provider.of<ProfileProvider>(context, listen: false).getSelectedAddress?.city ?? '';

    // full Address
    String fullAddress = Provider.of<ProfileProvider>(context, listen: false).getSelectedAddress?.address?.toString()??'';

    // type Address is home || office
    String typeAddress = await Provider.of<ProfileProvider>(context, listen: false).getSelectedAddress?.addressType ?? '';

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
            type,
            indexTypeCashApp, //1 google pay 2 apple pay 3 credit card
            fullAddress,
            typeAddress,
            Provider.of<CartProvider>(context, listen: false).shippingPrice.toInt(),
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
            null,
          govId: Provider.of<CartProvider>(context, listen: false).selectedShippingArea?.govId,
          cityId: Provider.of<CartProvider>(context, listen: false).selectedShippingArea?.zoneId,
          zoneId: Provider.of<CartProvider>(context, listen: false).selectedShippingArea?.id,
          couponCode: Provider.of<CouponProvider>(context, listen: false).couponCode,
        ),
        _route,
      PaymentMethod: paymentModel.shortcutName,
    );
  }

  _route(bool status, String? url, String message) {
    if (status) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(
                    url: url??'',
                    title: getTranslated("Complete_payment_process", context),
                  )));
    } else {
      showCustomSnackBar(message, context);
    }
  }
}
