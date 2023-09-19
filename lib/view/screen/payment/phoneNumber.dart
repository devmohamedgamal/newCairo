import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import 'package:lemirageelevators/provider/coupon_provider.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/cart_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../util/images.dart';
import '../../baseWidget/button/custom_button.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/dialog/animated_custom_dialog.dart';
import '../../baseWidget/my_dialog.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/spacer.dart';
import '../dashboard/dashboard_screen.dart';

class PhoneNumber extends StatefulWidget {
  final String type;
  final String note;
  PhoneNumber({required this.type,required this.note});
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}
class _PhoneNumberState extends State<PhoneNumber> {
  String c1 = '', c2 = '', c3 = '', c4 = '', c5 = '', c6 = '',
      c7 = '', c8 = '', c9 = '', c10 = '', c11 = '';
  TextEditingController? number;
  @override
  void initState() {
    super.initState();
    number = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('fawry', context)!),

          Padding(
            padding: const EdgeInsets.only(top:10,bottom: 25.0, right: 5, left: 5),
            child: Container(
              width: width(context) * 0.95,
              height: height(context) * 0.2,
              decoration: ShapeDecoration(
                  color: Colors.teal,
                  image: DecorationImage(
                      image: AssetImage(Images.fawry)
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5.0)),
                  )),
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.city),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    getTranslated("enter_wallet_number", context)!,
                    style: cairoBold
                  ),
                  HSpacer(30),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40, left: 40, top: 10),
                      child: Row(
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Expanded(
                              child: Column(
                                children: [
                                  Text(c1,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c2,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c3,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c4,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          WSpacer(5),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c5,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c6,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c7,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c8,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          WSpacer(5),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c9,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c10,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    c11,
                                    style: cairoBold
                                  ),
                                  HSpacer(5),
                                  c11 == ''
                                      ? Container(
                                      height: 1.5,
                                      width: 10,
                                      color: Colors.black)
                                      : Container()
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  HSpacer(25),
                  buildContainer(context, number!,
                      getTranslated("wallet_number", context)!,11,true),

                  Padding(
                      padding: EdgeInsets.fromLTRB(20,10,20,10),
                      child: Provider.of<OrderProvider>(context).isLoading
                          ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                          : CustomButton(
                        onTap: () async {
                          if(number!.text.isEmpty){
                            showCustomSnackBar(
                                getTranslated("PHONE_MUST_BE_REQUIRED", context)!,context);
                          }
                          else {
                            // items
                            List<CartItem>? _items = [];
                            Provider.of<CartProvider>(context,
                                listen: false).cartList.forEach((item) {
                              _items.add(
                                  CartItem(
                                    int.parse(item.variantId!),
                                    int.parse(item.id!),
                                    int.parse(item.quantity.toString()),
                                  ));
                            });

                            // client Id
                            String clientId = await Provider.of<AuthProvider>(context,
                                listen: false).user!.userId!;

                            // mobile
                            String mobile = await Provider.of<AuthProvider>(context,
                                listen: false).user!.mobile!;

                            // address City
                            String addressCity = await Provider.of<ProfileProvider>(context, listen: false).getSelectedAddress?.city ?? '';

                            // full Address
                            String fullAddress = Provider.of<ProfileProvider>(context, listen: false)
                                    .getSelectedAddress
                                    ?.address
                                    ?.toString() ?? '';

                                // type Address is home || office
                            String typeAddress = await Provider.of<ProfileProvider>(context, listen: false)
                                    .getSelectedAddress
                                    ?.addressType ?? '';

                                // shipping id
                            String shipping = await Provider.of<CartProvider>(context,
                                listen: false).shippingPlacesList[
                            Provider.of<CartProvider>(context,
                                listen: false).shippingPlacesIndex ?? 0
                            ].id.toString();

                            String amount = Provider.of<CartProvider>(context,
                                listen: false).amount.toString();

                            Provider.of<OrderProvider>(context,
                                listen: false).placeOrder(
                                CartModel(
                                    int.parse(clientId),
                                    widget.note,
                                    mobile,
                                    addressCity,
                                    3,
                                    null,
                                    fullAddress,
                                    typeAddress,
                                    int.tryParse(shipping),
                                    _items,
                                    PriceConverter.convertWithDiscount(
                                      discount: Provider.of<CouponProvider>(context, listen: false).discountPercentage,
                                      price: Provider.of<CartProvider>(context, listen: false).amount,
                                    ).toString(),
                                    widget.type,
                                    number!.text.trim().toString(),
                                    null,null,null,null
                                ),
                                _route
                            );
                          }
                        },
                        buttonText: getTranslated("Complete_payment_process", context)!,
                      )),
                ],
              )),
            )
          ),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext context, TextEditingController co,
      String hint,int len,bool ch) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(len),
                ],
                maxLines: 1,
                controller: co,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  labelText: hint,
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: Colors.teal, fontSize: 15),
                ),
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  if (ch){
                  for (int i = 0; i < text.length; i++) {
                    if (i == 0) {
                      setState(() {
                        c1 = text[i];
                      });
                    }
                    else if (i == 1) {
                      setState(() {
                        c2 = text[i];
                      });
                    }
                    else if (i == 2) {
                      setState(() {
                        c3 = text[i];
                      });
                    }
                    else if (i == 3) {
                      setState(() {
                        c4 = text[i];
                      });
                    }
                    else if (i == 4) {
                      setState(() {
                        c5 = text[i];
                      });
                    }
                    else if (i == 5) {
                      setState(() {
                        c6 = text[i];
                      });
                    }
                    else if (i == 6) {
                      setState(() {
                        c7 = text[i];
                      });
                    }
                    else if (i == 7) {
                      setState(() {
                        c8 = text[i];
                      });
                    }
                    else if (i == 8) {
                      setState(() {
                        c9 = text[i];
                      });
                    }
                    else if (i == 9) {
                      setState(() {
                        c10 = text[i];
                      });
                    }
                    else {
                      setState(() {
                        c11 = text[i];
                      });
                    }
                  }}
                }),
          ),
        ),
      ),
    );
  }

  _route(bool isSuccess,String? url,String message){
    if (isSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => DashBoardScreen()),
                  (route) => false);
          Provider.of<CartProvider>(context,listen: false).clearCart();
          showAnimatedDialog(
              context,MyDialog(
            icon: Icons.check,
            title: getTranslated('order_placed', context)!,
            description: getTranslated('your_order_placed', context)! + "\n" +
            getTranslated("success_fawry", context)!,
            isFailed: false,
          ),
              dismissible: false,isFlip: true);
        Provider.of<OrderProvider>(context,listen: false).stopLoader();
      }
    else {
        showCustomSnackBar(message,context);
      }
  }
}