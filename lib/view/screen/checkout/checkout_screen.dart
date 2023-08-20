import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/items_cart_model.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import 'package:lemirageelevators/provider/cart_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/checkout/widget/address_bottom_sheet.dart';
import 'package:lemirageelevators/view/screen/checkout/widget/custom_check_box.dart';
import 'package:lemirageelevators/view/screen/checkout/widget/shipping_method_bottom_sheet.dart';
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
import '../payment/payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<ItemsCartModel> cartList;
  final double totalOrderAmount;
  final double shippingCost;
  final int shippingIndex;
  CheckoutScreen({required this.cartList,
    required this.totalOrderAmount,
    required this.shippingIndex,
    required this.shippingCost,});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}
class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  TextEditingController? _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context,listen: false).initAddressTypeList(context);
    Provider.of<ProfileProvider>(context, listen: false).getAddress();
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
            child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0),
                children: [
                  // Shipping Details
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                    child: Column(children: [
                      InkWell(
                        onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => AddressBottomSheet()),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getTranslated('SHIPPING_TO', context),
                                  style: cairoRegular),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      Provider.of<ProfileProvider>(context).addressIndex == null
                                          ? getTranslated('add_your_address', context): Provider.of<ProfileProvider>(context,listen: false)
                                              .addressList[Provider.of<ProfileProvider>(context,
                                                   listen: false).addressIndex!].address!,
                                      style: cairoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                        width: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Image.asset(Images.EDIT_TWO,
                                        width: 15,
                                        height: 15,
                                        color:
                                            ColorResources.getPrimary(context)),
                                  ]),
                            ]),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Divider(
                            height: 2, color: ColorResources.getHint(context)),
                      ),

                      InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                          builder: (context) => ShippingMethodBottomSheet(index: Provider.of<CartProvider>(context,
                              listen: false).shippingPlacesIndex ?? 0),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(getTranslated('SHIPPING_PARTNER', context), style: cairoRegular),
                          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Text(
                              Provider.of<CartProvider>(context).shippingPlacesIndex == null
                                  ? getTranslated('select_shipping_method', context): Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                  ? Provider.of<CartProvider>(context,
                                  listen: false).shippingPlacesList[
                                    widget.shippingIndex].english!
                                  : Provider.of<CartProvider>(context,
                                  listen: false).shippingPlacesList[
                                    widget.shippingIndex].arabic!,
                              style: cairoSemiBold.copyWith(color: ColorResources.getPrimary(context)),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleRow(
                              title: getTranslated('ORDER_DETAILS', context),
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (_) => CartScreen()));
                              }),

                          Padding(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: Row(children: [
                              FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                image:
                                    '${AppConstants.BASE_URL_IMAGE}${widget.cartList[0].image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.placeholder,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50),
                              ),
                              SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
                              Expanded(
                                flex: 3,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                            ? widget.cartList[0].titleEn!
                                            : widget.cartList[0].title!,
                                        style: cairoRegular.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_SMALL,
                                            color: ColorResources.getPrimary(
                                                context)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                          height: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Row(children: [
                                        Text(widget.cartList[0].price.toString() + " \$",
                                          style: cairoSemiBold.copyWith(
                                              color: ColorResources.getPrimary(
                                                  context)),
                                        ),
                                        SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Text(
                                            widget.cartList[0].quantity.toString() + "x",
                                            style: cairoSemiBold.copyWith(
                                                color:
                                                    ColorResources.getPrimary(
                                                        context))),
                                        SizedBox(
                                            width:
                                            Dimensions.PADDING_SIZE_SMALL),
                                        Container(
                                          height: 20,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          margin: EdgeInsets.only(
                                              left: Dimensions
                                                  .MARGIN_SIZE_EXTRA_LARGE),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  color:
                                                      ColorResources.getPrimary(
                                                          context))),
                                          child: Text(
                                            PriceConverter.calculateTotal(context,
                                                widget.cartList[0].price.toString(),
                                                widget.cartList[0].quantity!) + " \$",
                                            style: cairoRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color:
                                                    ColorResources.getPrimary(
                                                        context)),
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
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleRow(title: getTranslated('TOTAL', context)),
                              AmountWidget(
                                  title: getTranslated('ORDER', context),
                                  amount: (widget.totalOrderAmount - widget.shippingCost).toString() + " \$"),
                              AmountWidget(
                                  title: getTranslated('SHIPPING_FEE', context),
                                  amount: widget.shippingCost.toString() + " \$"),
                              Divider(
                                  height: 5,
                                  color: Theme.of(context).hintColor),
                              AmountWidget(
                                  title: getTranslated('TOTAL_PAYABLE', context),
                                  amount: widget.totalOrderAmount.toString() + " \$"),
                            ]);
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
                              title: getTranslated('digital_payment', context),
                              index: 0,
                      ),
                      CustomCheckBox(
                        title: getTranslated('cash_on_delivery', context),
                        index: 1,
                      ),
                    ]),
                  ),

                  // note
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTranslated('Responsible_Person', context),
                                style: cairoRegular),

                            Image.asset(Images.EDIT_TWO,
                                      width: 15,
                                      height: 15,
                                      color:
                                      ColorResources.getPrimary(context)),
                          ]),

                      CustomTextField(
                        hintText: getTranslated('Responsible_Person', context),
                        controller: _noteController,
                        maxLine: 3,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),

                      Padding(
                        padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Divider(
                            height: 2, color: ColorResources.getHint(context)),
                      ),
                    ]),
                  ),
                ]),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
            vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            color: ColorResources.getPrimary(context),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: Consumer<OrderProvider>(
          builder: (context, order, child) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated('TOTAL', context)+ " " + widget.totalOrderAmount.toString() + " \$",
                    style: cairoSemiBold.copyWith(
                        color: Theme.of(context).highlightColor),
                  ),

                  !Provider.of<OrderProvider>(context).isLoading
                      ? TextButton(
                    onPressed: () async {
                      if (Provider.of<ProfileProvider>(context,
                          listen: false).addressIndex == null) {
                        showCustomSnackBar(getTranslated('select_a_shipping_address', context), context);
                      }
                      else if (Provider.of<CartProvider>(context,
                          listen: false).shippingPlacesIndex == null) {
                        showCustomSnackBar(getTranslated('select_a_shipping_address', context), context);
                      }
                      else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChoicePayment(note: _noteController!.text.toString())));
                        }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      backgroundColor: Theme.of(context).highlightColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).highlightColor)),
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
  PaymentButton({required this.image,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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