import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/order_model.dart';
import 'package:lemirageelevators/helper/price_converter.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../product/review_dialog.dart';

class OrderDetailsWidget extends StatelessWidget {
  final OrderItem? orderItem;
  final Function()? callback;
  OrderDetailsWidget({this.orderItem, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Provider.of<ProductProvider>(context, listen: false).removeData();
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => ReviewBottomSheet(
                  productID: orderItem!.productId.toString(),
                  callback: callback!));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.scaleDown,
                  width: 50,
                  height: 50,
                  image: '${AppConstants.BASE_URL_IMAGE}${orderItem!.pavatar}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.scaleDown,
                      width: 50,
                      height: 50),
                ),
                SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                            ? orderItem!.productNameEN!
                            : orderItem!.productName!,
                        style: cairoSemiBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).hintColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                      //quantity && total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${orderItem!.price ?? "0.0"}" + " \$",
                            style: cairoSemiBold.copyWith(
                                color: ColorResources.getPrimary(context)),
                          ),
                          Text('${orderItem!.qty} x',
                              textDirection: TextDirection.ltr,
                              style: cairoSemiBold.copyWith(
                                  color: ColorResources.getPrimary(context))),
                          Container(
                            height: 20,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: ColorResources.getPrimary(context))),
                            child: Text(
                              PriceConverter.calculateTotal(
                                  context,
                                  orderItem!.price!,
                                  int.parse(orderItem!.qty!)) + " \$",
                              style: cairoRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  color: ColorResources.getPrimary(context)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            orderItem!.sizeName == null && orderItem!.kindName == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Row(children: [
                      SizedBox(width: 65),
                      Text(orderItem!.sizeName! + " :   ",
                          style: cairoSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL),),
                      Text(orderItem!.kindName!,
                          style: cairoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor,
                          ),),
                    ]),
                  ),

            Divider(),
          ],
        ));
  }
}