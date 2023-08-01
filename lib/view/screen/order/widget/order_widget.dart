import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import '../../../../data/model/response/order_model.dart';
import '../../../../helper/date_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  OrderWidget({required this.order});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order)));
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: Dimensions.PADDING_SIZE_SMALL,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(5)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // date && id
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // id order
            Row(children: [
              Text(getTranslated('ORDER_ID', context)!,
                  style: cairoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(order.id.toString(), style: cairoSemiBold),
            ]),

            // order date
            Row(children: [
              Text(getTranslated('order_date', context)!,
                  style: cairoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(
                  DateConverter.isoStringToLocalDateOnly(
                      order.adate.toString()),
                  style: cairoRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).hintColor,
                  )),
            ]),
          ]),

              SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

              //total && status
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(getTranslated('total_price', context)!,
                style: cairoRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL)),
                Text((double.parse(order.orderPrice ?? "0.0") +
                    double.parse(order.shippingCost!.isEmpty
                        ? "0.0"
                        : order.shippingCost ?? "0.0")).toString(),
                    style: cairoSemiBold),
                SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                color: ColorResources.getLowGreen(context),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(order.status!.toUpperCase(), style: cairoSemiBold),
            ),
          ]),
        ]),
      ),
    );
  }
}