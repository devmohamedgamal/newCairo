import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/body/payment_order_model.dart';
import 'package:lemirageelevators/data/model/body/payment_shipping_data_model.dart';
import 'package:lemirageelevators/di_container.dart';
import 'package:lemirageelevators/provider/payment_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/view/baseWidget/button/custom_button.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:lemirageelevators/view/screen/payment/phoneNumber.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/cart_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/web_view_screen.dart';
import 'masterCard.dart';

class ChoicePayment extends StatefulWidget {
  final String note;

  const ChoicePayment({required this.note});

  @override
  _ChoicePaymentState createState() => _ChoicePaymentState();
}

class _ChoicePaymentState extends State<ChoicePayment> {
  int typePayment = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentProvider>(
      create: (context) {
        // // client Id
        // String clientId = await Provider.of<AuthProvider>(context, listen: false).user!.userId!;
        //
        // // mobile
        // String mobile = await Provider.of<AuthProvider>(context, listen: false).user!.mobile!;
        //
        // // address City
        // String addressCity = await Provider.of<ProfileProvider>(context, listen: false)
        //     .addressList[Provider.of<ProfileProvider>(context, listen: false).addressIndex!]
        //     .city!;
        //
        // // full Address
        // String fullAddress = Provider.of<ProfileProvider>(context, listen: false)
        //     .addressList[Provider.of<ProfileProvider>(context, listen: false).addressIndex!]
        //     .address
        //     .toString();
        //
        // // type Address is home || office
        // String typeAddress = await Provider.of<ProfileProvider>(context, listen: false)
        //     .addressList[Provider.of<ProfileProvider>(context, listen: false).addressIndex!]
        //     .addressType!;
        //
        // // shipping id
        // String shipping = await Provider.of<CartProvider>(context, listen: false)
        //     .shippingPlacesList[Provider.of<CartProvider>(context, listen: false).shippingPlacesIndex ?? 0]
        //     .id
        //     .toString();
        //
        //
        // int? indexTypeCashApp = Provider.of<CartProvider>(context, listen: false).indexType;
        //
        // CartModel(
        //     int.parse(clientId),
        //     note,
        //     mobile,
        //     addressCity,
        //     type,
        //     indexTypeCashApp,
        //     //1 google pay 2 apple pay 3 credit card
        //     fullAddress,
        //     typeAddress,
        //     int.parse(shipping),
        //     _items,
        //     amount,
        //     mobileType,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null);
        final amount = Provider.of<CartProvider>(context, listen: false).amount;
        final paymentOrderModel = PaymentOrderModel(
          amountCents: amount.toInt() * 100,
          paymentShippingDataModel: PaymentShippingDataModel(
            email: 'mostafa@gmail.com',
            firstName: 'Mostafa',
            lastName: 'Alazhariy',
            phoneNumber: '01013688985',
            extraDescription: 'order some things .. extra description here'
          ),
        );
        return sl<PaymentProvider>()
          ..initPayment(
            orderModel: paymentOrderModel,
            integrationId: 4111870,
          );
      },
      child: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, _){
          return Scaffold(
            body: Column(
              children: [
                CustomAppBar(title: getTranslated('payment_method', context)!),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Provider.of<SplashProvider>(context, listen: false).appInfo!.master == "1"
                            ? typePaymentWidget(
                            title: "MasterCard",
                            image: Images.master_card,
                            value: typePayment == 0 ? true : false,
                            onChanged: () {
                              setState(() {
                                typePayment = 0;
                              });
                            })
                            : Container(),
                        Provider.of<SplashProvider>(context, listen: false).appInfo!.fawry == "1"
                            ? typePaymentWidget(
                            title: "Fawry",
                            image: Images.fawry,
                            value: typePayment == 1 ? true : false,
                            onChanged: () {
                              setState(() {
                                typePayment = 1;
                              });
                            })
                            : Container(),
                        Provider.of<SplashProvider>(context, listen: false).appInfo!.stripe == "1"
                            ? typePaymentWidget(
                            title: "Stripe",
                            value: typePayment == 2 ? true : false,
                            image: Images.stripe,
                            onChanged: () {
                              setState(() {
                                typePayment = 2;
                              });
                            })
                            : Container(),
                        Provider.of<SplashProvider>(context, listen: false).appInfo!.paypal == "1"
                            ? typePaymentWidget(
                            title: "PayPal",
                            value: typePayment == 3 ? true : false,
                            image: Images.paypal,
                            onChanged: () {
                              setState(() {
                                typePayment = 3;
                              });
                            })
                            : Container(),
                        Provider.of<SplashProvider>(context, listen: false).appInfo!.cashApp == "1"
                            ? typePaymentWidget(
                            title: "Cash App",
                            value: typePayment == 4 ? true : false,
                            image: Images.cashApp,
                            onChanged: () {
                              setState(() {
                                typePayment = 4;
                              });
                            })
                            : Container(),
                        typePayment == 4
                            ? Consumer<CartProvider>(builder: (context, cardProvider, child) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_DEFAULT,
                              right: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 1), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                            ),
                            alignment: Alignment.center,
                            child: DropdownButtonFormField<String>(
                              value: cardProvider.paymentType,
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(border: InputBorder.none),
                              iconSize: 24,
                              elevation: 16,
                              style: cairoRegular,
                              onChanged: cardProvider.updatePaymentType,
                              items: cardProvider.paymentTypeList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: cairoRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)),
                                );
                              }).toList(),
                            ),
                          );
                        })
                            : Container()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.payment),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: CustomButton(
                  onTap: () async {
                    if (Platform.isAndroid) {
                      if (typePayment == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MasterCard(note: widget.note, type: "Android")));
                      } else if (typePayment == 1) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumber(note: widget.note, type: "Android")));
                      } else if (typePayment == 2) {
                        _paymentIsStripeOrPayPalOrCashApp(type: 4, note: widget.note, mobileType: "Android");
                      } else if (typePayment == 3) {
                        _paymentIsStripeOrPayPalOrCashApp(type: 5, note: widget.note, mobileType: "Android");
                      } else if (typePayment == 4) {
                        _paymentIsStripeOrPayPalOrCashApp(type: 6, note: widget.note, mobileType: "Android");
                      }
                    } else {
                      if (typePayment == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MasterCard(note: widget.note, type: "Iphone")));
                      } else if (typePayment == 1) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumber(note: widget.note, type: "Iphone")));
                      } else if (typePayment == 2) {
                        _paymentIsStripeOrPayPalOrCashApp(type: 4, note: widget.note, mobileType: "Iphone");
                      } else if (typePayment == 3) {
                        _paymentIsStripeOrPayPalOrCashApp(type: 5, note: widget.note, mobileType: "Iphone");
                      } else if (typePayment == 4) {
                        _paymentIsStripeOrPayPalOrCashApp(type: 6, note: widget.note, mobileType: "Iphone");
                      }
                    }
                  },
                  buttonText: getTranslated("NEXT", context)!,
                )),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
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

  Future<void> _paymentIsStripeOrPayPalOrCashApp({required int type, required String mobileType, required String note}) async {
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
            type,
            indexTypeCashApp,
            //1 google pay 2 apple pay 3 credit card
            fullAddress,
            typeAddress,
            int.parse(shipping),
            _items,
            amount,
            mobileType,
            null,
            null,
            null,
            null,
            null),
        _route);
  }

  _route(bool status, String? url, String message) {
    if (status) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(
                    url: url!,
                    title: getTranslated("Complete_payment_process", context)!,
                  )));
    } else {
      showCustomSnackBar(message, context);
    }
  }
}
