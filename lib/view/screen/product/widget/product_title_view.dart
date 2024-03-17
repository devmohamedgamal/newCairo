import 'package:flutter/material.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../../../data/model/response/Product/product.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/rating_bar.dart';

class ProductTitleView extends StatelessWidget {
  final Product product;
  const ProductTitleView({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).highlightColor,
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Consumer<ProductProvider>(
        builder: (context, details, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    Provider.of<LocalizationProvider>(context)
                                .locale!
                                .languageCode ==
                            "en"
                        ? product.titleEn ?? 'No Title'
                        : product.title ?? 'لا يوجد عنوان',
                    style: cairoSemiBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE),
                    maxLines: 2),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${product.price!} ${getTranslated('currency', context)}",
                  style: cairoBold.copyWith(
                      color: ColorResources.getPrimary(context),
                      fontSize: Dimensions.FONT_SIZE_LARGE),
                ),
                double.parse(product.priceBefore?.replaceAll(",", "") ?? '0') >
                        0
                    ? Text(
                        product.priceBefore! +
                            " ${getTranslated('currency', context)}",
                        style: cairoRegular.copyWith(
                            color: Theme.of(context).hintColor,
                            decoration: TextDecoration.lineThrough),
                      )
                    : const SizedBox(),
              ]);
        },
      ),
    );
  }
}
