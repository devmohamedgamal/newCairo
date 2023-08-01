// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/order_provider.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/order/widget/order_details_widget.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/date_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../baseWidget/amount_widget.dart';
import '../../baseWidget/button/custom_button.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/shimmer_loading.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/title_row.dart';
import '../tracking/tracking_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    _route(bool status,String message){
      if(status){
        showCustomSnackBar(message,context,isError: false);
        Provider.of<OrderProvider>(context,
            listen: false).initOrderList(context,
            Provider.of<AuthProvider>(context,
                listen: false).user!.userId!
        );
        Navigator.pop(context);
      }
      else{
        showCustomSnackBar(message,context);
      }
    }
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(title: getTranslated('ORDER_DETAILS', context)!),
          Expanded(
            child: order != null
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    children: [
                      // id && date
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: getTranslated('ORDER_ID', context),
                                      style: cairoRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: Theme.of(context).textTheme.bodyText1!.color,
                                      )),
                                  TextSpan(
                                      text: "  " + order.id.toString(),
                                      style: cairoSemiBold.copyWith(color: ColorResources.BLACK)),
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox()),

                            Text(DateConverter.localDateToIsoStringAMPM(
                                DateTime.parse(order.adate.toString())),
                                style: cairoRegular.copyWith(
                                    color: ColorResources.getTextTitle(context),
                                    fontSize: Dimensions.FONT_SIZE_SMALL)),
                          ],
                        ),
                      ),

                      //way
                      Container(
                        padding:
                            EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                        decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                        child: Column(
                          children: [
                            Row(children: [
                              Expanded(
                                  child: Text(getTranslated('SHIPPING_TO', context)!,
                                      style: cairoRegular)),
                              Text(
                                  order.fullAddress ?? "",
                                  style: cairoRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL))
                            ]),
                            Divider(),
                            Row(children: [
                              Expanded(
                                  child: Text(getTranslated('SHIPPING_PARTNER', context)!,
                                      style: cairoRegular)),
                              Text(order.way == null || order.way!.isEmpty
                                  ? ""
                                  : order.way.toString(),
                                  style: cairoSemiBold.copyWith(
                                      color: ColorResources.getPrimary(context))),
                            ]),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                      Container(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        color: Theme.of(context).highlightColor,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  getTranslated('ORDERED_PRODUCT', context)!,
                                  style: cairoBold.copyWith(
                                      color: Theme.of(context).hintColor)),
                              Divider(),
                            ]),
                      ),

                      //items
                      ListView.builder(
                        itemCount: order.orderItems!.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                                vertical: Dimensions.MARGIN_SIZE_SMALL),
                            color: Theme.of(context).highlightColor,
                            child: OrderDetailsWidget(
                                orderItem: order.orderItems![index],
                                callback: () {showCustomSnackBar(
                                    getTranslated("Review_submitted_successfully", context)!,
                                    context, isError: false);}
                            ),
                          );
                        },
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                      // Amounts
                      Container(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        color: Theme.of(context).highlightColor,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleRow(
                                  title: getTranslated('TOTAL', context)!),

                              AmountWidget(
                                  title: getTranslated('ORDER', context)!,
                                  amount: "${order.orderPrice ?? "0.0"}" + " \$"
                              ),

                              AmountWidget(
                                  title: getTranslated(
                                      'SHIPPING_FEE', context)!,
                                  amount: order.shippingCost!.isEmpty || order.shippingCost == null
                                      ? "0.0" + " \$"
                                      : "${order.shippingCost ?? "0.0"}" + " \$",
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions
                                        .PADDING_SIZE_EXTRA_SMALL),
                                child: Divider(
                                    height: 2,
                                    color: ColorResources.HINT_TEXT_COLOR),
                              ),

                              AmountWidget(
                                title:
                                    getTranslated('TOTAL_PAYABLE', context)!,
                                amount: (double.parse(order.orderPrice ?? "0.0") +
                                    double.parse(order.shippingCost!.isEmpty
                                        ? "0.0"
                                        : order.shippingCost ?? "0.0")).toString() + " \$"
                              ),
                            ]),
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                      // Payment
                      Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated('PAYMENT', context)!,
                                  style: cairoBold),
                              SizedBox(
                                  height:
                                      Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(getTranslated('PAYMENT_STATUS', context)!,
                                        style: cairoRegular.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_SMALL)),
                                    Text(order.paymentStatus == "paid"
                                        ? getTranslated('paid', context)!
                                        : getTranslated('un_paid', context)!,
                                      style: cairoRegular.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_SMALL),
                                    ),
                                  ]),
                            ]),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                      // Buttons
                      Provider.of<OrderProvider>(context).orderTypeIndex != 0
                          ? Container()
                          : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_LARGE,
                            vertical: Dimensions.PADDING_SIZE_SMALL),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                buttonText: getTranslated('order_tracking', context)!,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              TrackingScreen(
                                                  order: order)));
                                },
                              ),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                            Provider.of<OrderProvider>(context).isLoading
                                  ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                                  : Expanded(
                              child: SizedBox(
                                height: 45,
                                child: TextButton(
                                  onPressed: () async {
                                   await Provider.of<OrderProvider>(context,
                                        listen: false).cancelOrder(
                                       order.id!,
                                       _route);
                                  },
                                  child: Text(
                                    getTranslated('Cancelling_order', context)!,
                                    style: cairoSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.getPrimary(
                                            context)),
                                  ),
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                        color: ColorResources.getPrimary(
                                            context)),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : LoadingPage()
          )
        ],
      ),
    );
  }
}