import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/tracking/painter/line_dashed_painter.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/order_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/order_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../dashboard/dashboard_screen.dart';

class TrackingScreen extends StatelessWidget {
  final Order order;
  TrackingScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('DELIVERY_STATUS', context)!),

          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, tracking, child) {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(getTranslated('ESTIMATED_DELIVERY', context)!,
                            style: cairoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL)),
                        Text("20/20/20-20",
                            style: cairoSemiBold.copyWith(fontSize: 20.0)),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // for status and order id section
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL,
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(getTranslated('ORDER_STATUS', context)!,
                                    style: cairoSemiBold),

                                RichText(
                                  text: TextSpan(
                                    text: getTranslated('ORDER_ID', context),
                                    style: cairoRegular.copyWith(
                                      color: ColorResources.BLACK,
                                        fontSize: Dimensions.FONT_SIZE_SMALL),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: order.id,
                                          style: cairoSemiBold),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            margin:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            color: ColorResources.getPrimary(context),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          // Steppers
                          CustomStepper(
                              title: order.status == 'pending'
                                  ? getTranslated('processing', context)!
                                  : getTranslated(
                                  'ORDER_PLACED_PREPARING', context)!,
                              color: ColorResources.getHarlequin(context)),


                          CustomStepper(
                              title: order.status == 'pending'
                                  ? getTranslated('pending', context)!
                                  : order.status == 'confirmed'
                                  ? getTranslated('processing', context)!
                                  : getTranslated(
                                  'ORDER_PICKED_SENDING', context)!,
                              color: ColorResources.getCheris(context)),


                          CustomStepper(
                              title: order.status == 'pending'
                                  ? getTranslated('pending', context)!
                                  : order.status == 'confirmed'
                                  ? getTranslated('pending', context)!
                                  : order.status == 'processing'
                                  ? getTranslated(
                                  'processing', context)!
                                  : getTranslated(
                                  'RECEIVED_LOCAL_WAREHOUSE',
                                  context)!,
                              color: ColorResources.getColombiaBlue(context)),


                          CustomStepper(
                              title: order.status == 'pending'
                                  ? getTranslated('pending', context)!
                                  : order.status == 'confirmed'
                                  ? getTranslated('pending', context)!
                                  : order.status == 'processing'
                                  ? getTranslated('pending', context)!
                                  : order.status == 'out_for_delivery'
                                  ? getTranslated(
                                  'processing', context)!
                                  : getTranslated(
                                  'DELIVERED', context)!,
                              color: Theme.of(context).primaryColor,
                              isLastItem: true),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // for button
          Container(
            height: 45,
            margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            decoration: BoxDecoration(
                color: ColorResources.getImageBg(context),
                borderRadius: BorderRadius.circular(6)),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => DashBoardScreen()),
                        (route) => false);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  getTranslated('ORDER_MORE', context)!,
                  style: cairoSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: ColorResources.getPrimary(context)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final String title;
  final Color color;
  final bool isLastItem;

  CustomStepper(
      {required this.title, required this.color, this.isLastItem = false});

  @override
  Widget build(BuildContext context) {
    Color myColor;
    if (title == getTranslated('processing', context) ||
        title == getTranslated('pending', context)) {
      myColor = ColorResources.GREY;
    } else {
      myColor = color;
    }
    return Container(
      height: isLastItem ? 50 : 100,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: CircleAvatar(backgroundColor: myColor, radius: 10.0),
              ),
              Text(title, style: cairoRegular)
            ],
          ),

          isLastItem
              ? SizedBox.shrink()
              : Padding(
            padding: EdgeInsets.only(
                top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                left: Dimensions.PADDING_SIZE_LARGE),
            child: CustomPaint(painter: LineDashedPainter(myColor)),
          ),
        ],
      ),
    );
  }
}