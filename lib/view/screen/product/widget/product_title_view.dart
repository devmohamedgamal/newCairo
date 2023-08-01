import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../../../data/model/response/home_model.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/rating_bar.dart';

class ProductTitleView extends StatelessWidget {
  final Product product;
  ProductTitleView({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).highlightColor,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Consumer<ProductProvider>(
        builder: (context, details, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(product.price! + " \$",
                style: cairoBold.copyWith(
                    color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
              SizedBox(width: 20),

              // Expanded(child: SizedBox.shrink()),

              InkWell(
                onTap: () {
                  if(product.url != null && product.url!.isNotEmpty) {
                    Share.share(product.url!);
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    boxShadow: [BoxShadow(
                        color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200]!,
                        spreadRadius: 1, blurRadius: 5)],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.share, color: ColorResources.getPrimary(context), size: Dimensions.ICON_SIZE_SMALL),
                ),
              ),
            ]),

            double.parse(product.priceBefore!.replaceAll(",","")) > 0
                ? Text(product.priceBefore! + " \$",
              style: cairoRegular.copyWith(color: Theme.of(context).hintColor, decoration: TextDecoration.lineThrough),
            )
                : SizedBox(),

            Text(
                Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                    ? product.titleEn ?? ''
                    : product.title ?? '',
                style: cairoSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE), maxLines: 2),

            Row(children: [
              Text(product.rate != null ? product.rate!.length > 0
                  ? double.parse(product.rate!).toStringAsFixed(1)
                  : '0.0' : '0.0', style: cairoSemiBold.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              )),
              SizedBox(width: 5),

              RatingBar(
                  rating: product.rate != null
                      ? product.rate!.length > 0
                        ? double.parse(product.rate ?? "0.0")
                        : 0.0
                      : 0.0),

              // Expanded(child: SizedBox.shrink()),
            ]),
          ]);
        },
      ),
    );
  }
}