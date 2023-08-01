import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/order_model.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';

class OrderProductWidget extends StatelessWidget {
  final Order order;
  OrderProductWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: ColorResources.WHITE),
      child: Row(children: [

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder, height: 50, width: 50,
            image: '${AppConstants.BASE_URL_IMAGE}dd.png',
            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                height: 50, width: 50),
          ),
        ),

        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('abc', maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: cairoRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                    color: ColorResources.HINT_TEXT_COLOR,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        //PriceConverter.convertPrice(context, cartModel.price),
                        '200',
                        style: cairoSemiBold.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        width: 50,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Text('${100}% OFF', textAlign: TextAlign.center,
                            style: cairoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.HINT_TEXT_COLOR,
                        )),
                      ),
                      Container(
                        width: 50,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(getTranslated('review', context)!,
                            textAlign: TextAlign.center,
                            style: cairoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.WHITE,
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}