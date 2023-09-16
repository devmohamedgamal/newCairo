import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/items_cart_model.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';

class CartWidget extends StatelessWidget {
  final ItemsCartModel? itemsCartModel;
  final int index;
  const CartWidget({this.itemsCartModel,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder, height: 50, width: 50,
            image: '${AppConstants.BASE_URL_IMAGE}${itemsCartModel!.image}',
            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 50, width: 50),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                      ? itemsCartModel!.titleEn!
                      : itemsCartModel!.title! , maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: cairoBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: ColorResources.getHint(context),
                  )),
                  Text(
                    itemsCartModel!.price.toString() + " ${getTranslated('currency', context)}",
                    textDirection: TextDirection.ltr,
                    style: cairoSemiBold.copyWith(color: ColorResources.getPrimary(context)),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_SMALL,
                            left: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        child: QuantityButton(
                            isIncrement: false, index: index,
                            quantity: itemsCartModel!.quantity ?? 1,
                            maxQty: itemsCartModel!.maxQty ?? 0,
                            itemsCartModel: itemsCartModel!),
                      ),

                      Text(itemsCartModel!.quantity.toString(), style: cairoSemiBold),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: QuantityButton(
                            index: index, isIncrement: true,
                            quantity: itemsCartModel!.quantity ?? 1,
                            maxQty: itemsCartModel!.maxQty ?? 0,
                            itemsCartModel: itemsCartModel!),
                      ),
                    ],
                  ),

                  itemsCartModel!.variantId != null && itemsCartModel!.variantId!.isNotEmpty
                      ? Padding(
                    padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Row(children: [
                      Text('${getTranslated('variant', context)}  :  ',
                          style: cairoSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                      Flexible(child: Text(itemsCartModel!.variantName == null ||
                          itemsCartModel!.variantName!.isEmpty
                          ? " "
                          : itemsCartModel!.variantName ?? "",
                          style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor,))),
                    ]),
                  )
                      : SizedBox(),
                ],
              ),
          ),
        ),

        IconButton(
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).removeFromCart(index);
          },
          icon: Icon(Icons.cancel, color: ColorResources.RED),
        )
      ]),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final ItemsCartModel itemsCartModel;
  final bool isIncrement;
  final int quantity;
  final int index;
  final int maxQty;
  QuantityButton({required this.isIncrement,required this.quantity,
    required this.index,required this.maxQty, required this.itemsCartModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isIncrement && quantity > 1) {
          Provider.of<CartProvider>(context,listen: false).setQuantity(false, index);
        }
        else if (isIncrement && quantity < maxQty) {
          Provider.of<CartProvider>(context, listen: false).setQuantity(true, index);
        }
      },
      child: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? quantity >= maxQty ? ColorResources.getGrey(context)
            : ColorResources.getPrimary(context)
            : quantity > 1
            ? ColorResources.getPrimary(context)
            : ColorResources.getGrey(context),
        size: 20,
      ),
    );
  }
}