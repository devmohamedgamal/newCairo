import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import 'package:lemirageelevators/provider/coupon_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/button/custom_button.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/cart_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../util/images.dart';
import '../../../util/responsive.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/spacer.dart';
import '../../baseWidget/web_view_screen.dart';

class MasterCard extends StatefulWidget {
  final String type;
  final String note;
  MasterCard({required this.type,required this.note});
  @override
  _MasterCardState createState() => _MasterCardState();
}
class _MasterCardState extends State<MasterCard> {
  String c1 = '',
      c2 = '',
      c3 = '',
      c4 = '',
      c5 = '',
      c6 = '',
      c7 = '',
      c8 = '',
      c9 = '',
      c10 = '',
      c11 = '',
      c12 = '',
      c13 = '',
      c14 = '',
      c15 = '',
      c16 = '',
      m = "- -",
      y = "- -",
      n = "Your name here",
      c = "CVV";
  TextEditingController? name, number, month, year, cvv, phone;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    super.initState();
    name = TextEditingController();
    number = TextEditingController();
    month = TextEditingController();
    year = TextEditingController();
    cvv = TextEditingController();
    phone = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            CustomAppBar(title: getTranslated('master_card', context)!),

            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                          width: width(context),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(Images.bg_card))),
                          child: Column(
                            textDirection: TextDirection.ltr,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 10, 20.0, 5.0),
                                child: Row(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(Images.Group),
                                    WSpacer(10),
                                    Text("$m / $y")
                                  ],
                                ),
                              ),

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  child: Row(
                                    textDirection: TextDirection.ltr,
                                    children: <Widget>[
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c1,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c2,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c3,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c4,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      WSpacer(10),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c5,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c6,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c7,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c8,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      WSpacer(10),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c9,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c10,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c11,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c12,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      WSpacer(10),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c13,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c14,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c15,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            c16,
                                            style: cairoRegular.copyWith(
                                              color: ColorResources.WHITE,
                                            ),
                                          ),
                                          HSpacer(5),
                                          c16 == ''
                                              ? Container(
                                                  height: 1.5,
                                                  width: 10,
                                                  color: Colors.white)
                                              : Container()
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20,20,20,0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Card Holder",
                                        style: cairoRegular.copyWith(
                                            color: ColorResources.WHITE,
                                            fontSize: 15)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(n,
                                            style: cairoBold.copyWith(
                                              color: ColorResources.WHITE
                                            )),
                                        Image.asset(Images.master_card)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),

                      back: Container(
                          width: width(context),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(Images.bg_card))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  color: Colors.amber.withOpacity(0.5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, bottom: 100),
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.white30,
                                      width: width(context) * 0.7,
                                      height: 30,
                                    ),
                                    WSpacer(5),
                                    Text(
                                      "$c",
                                      style: cairoBold.copyWith(
                                          color: ColorResources.WHITE, fontSize: 20
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    width: width(context),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          buildContainer(
                              context,
                              number!,
                              getTranslated("Card_Number", context)!,
                              null,
                              width(context),
                              0,
                              16,
                              true),
                          buildContainer(
                              context,
                              name!,
                              getTranslated("Card_Holder_Name", context)!,
                              null,
                              width(context),
                              1,
                              50,
                              false),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildContainer(
                                  context,
                                  month!,
                                  getTranslated("Month", context)!,
                                  Icons.arrow_forward_ios_outlined,
                                  width(context) * 0.4,
                                  2,
                                  2,
                                  true),
                              buildContainer(
                                  context,
                                  year!,
                                  getTranslated("Year", context)!,
                                  Icons.arrow_forward_ios_outlined,
                                  width(context) * 0.4,
                                  3,
                                  2,
                                  true),
                            ],
                          ),
                          buildContainer(
                              context,
                              cvv!,
                              getTranslated("cvv", context)!,
                              null,
                              width(context),
                              4,
                              3,
                              true),
                          buildContainer(
                              context,
                              phone!,
                              getTranslated("PHONE_NO", context)!,
                              null,
                              width(context),
                              5,
                              11,
                              true),
                          HSpacer(10),
                          Padding(
                              padding: EdgeInsets.all(10),
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
                                    if (number!.text.isEmpty) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              "must_enter_MasterCard_number",
                                              context)!,
                                          context);
                                    }
                                    else if (name!.text.isEmpty) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              "must_enter_MasterCard_holder",
                                              context)!,
                                          context);
                                    }
                                    else if (month!.text.isEmpty ||
                                        year!.text.isEmpty) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              "must_enter_MasterCard_data",
                                              context)!,
                                          context);
                                    }
                                    else if (year!.text.length < 2) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              "must_enter_MasterCard_year",
                                              context)!,
                                          context);
                                    }
                                    else if (cvv!.text.isEmpty) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              "must_enter_MasterCard_cvv",
                                              context)!,
                                          context);
                                    } else if (cvv!.text.length < 3) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              "must_verified_MasterCard_cvv",
                                              context)!,
                                          context);
                                    }
                                    else if (int.parse(month!.text) > 12) {
                                      showCustomSnackBar(
                                          getTranslated(
                                              "must_verified_MasterCard_month",
                                              context)!,
                                          context);
                                    }
                                    else {
                                      String mo;
                                      month!.text.length == 1
                                          ? mo = "0${month!.text}"
                                          : mo = month!.text;

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
                                      String addressCity = await Provider.of<ProfileProvider>(context,
                                          listen: false).addressList[
                                      Provider.of<ProfileProvider>(context,
                                          listen: false).addressIndex!
                                      ].city!;

                                      // full Address
                                      String fullAddress = Provider.of<ProfileProvider>(context,
                                          listen: false).addressList[
                                      Provider.of<ProfileProvider>(context,
                                          listen: false).addressIndex!
                                      ].address.toString();

                                      // type Address is home || office
                                      String typeAddress = await Provider.of<ProfileProvider>(context,
                                          listen: false).addressList[
                                      Provider.of<ProfileProvider>(context,
                                          listen: false).addressIndex!
                                      ].addressType!;

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
                                              2,
                                              null,
                                              fullAddress,
                                              typeAddress,
                                              int.parse(shipping),
                                              _items,
                                              PriceConverter.convertWithDiscount(
                                                discount: Provider.of<CouponProvider>(context, listen: false).discountPercentage,
                                                price: Provider.of<CartProvider>(context, listen: false).amount,
                                              ).toString(),
                                              widget.type,phone!.text.toString(),
                                              number!.text,cvv!.text,y,mo
                                          ),
                                          _route
                                      );
                                    }
                                  },
                                  buttonText: getTranslated(
                                      "Complete_payment_process", context)!)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
    );
  }

  Widget buildContainer(BuildContext context, TextEditingController co,
      String hint, IconData? icon, double width, int check,
      int length, bool isNumber) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
      child: Container(
        width: width,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(length),
              check == 1
                  ? FilteringTextInputFormatter(RegExp("[a-z A-Z]"),
                      allow: true)
                  : FilteringTextInputFormatter(RegExp("[0-9]"), allow: true)
            ],
            maxLines: 1,
            controller: co,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            style: TextStyle(color: Colors.black, fontSize: 20),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                labelText: hint,
                labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                suffixIcon: Icon(icon)),
            textInputAction: TextInputAction.next,
            onChanged: (text) {
              if (check == 0) {
                for (int i = 0; i < text.length; i++) {
                  if (i == 0) {
                    setState(() {
                      c1 = text[i];
                    });
                  } else if (i == 1) {
                    setState(() {
                      c2 = text[i];
                    });
                  } else if (i == 2) {
                    setState(() {
                      c3 = text[i];
                    });
                  } else if (i == 3) {
                    setState(() {
                      c4 = text[i];
                    });
                  } else if (i == 4) {
                    setState(() {
                      c5 = text[i];
                    });
                  } else if (i == 5) {
                    setState(() {
                      c6 = text[i];
                    });
                  } else if (i == 6) {
                    setState(() {
                      c7 = text[i];
                    });
                  } else if (i == 7) {
                    setState(() {
                      c8 = text[i];
                    });
                  } else if (i == 8) {
                    setState(() {
                      c9 = text[i];
                    });
                  } else if (i == 9) {
                    setState(() {
                      c10 = text[i];
                    });
                  } else if (i == 10) {
                    setState(() {
                      c11 = text[i];
                    });
                  } else if (i == 11) {
                    setState(() {
                      c12 = text[i];
                    });
                  } else if (i == 12) {
                    setState(() {
                      c13 = text[i];
                    });
                  } else if (i == 13) {
                    setState(() {
                      c14 = text[i];
                    });
                  } else if (i == 14) {
                    setState(() {
                      c15 = text[i];
                    });
                  } else if (i == 15) {
                    setState(() {
                      c16 = text[i];
                    });
                  }
                }
              } else if (check == 1) {
                setState(() {
                  n = text;
                });
              } else if (check == 2) {
                setState(() {
                  m = text;
                });
              } else if (check == 3) {
                setState(() {
                  y = text;
                });
              } else if (check == 4) {
                setState(() {
                  c = text;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  _route(bool status,String? url,String message) {
    if(status){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=> WebViewScreen(
              url: url!, title: getTranslated("Complete_payment_process", context)!,
          )));
    }
    else {
      showCustomSnackBar(
          message, context);
    }
  }
}