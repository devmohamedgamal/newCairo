import 'package:flutter/material.dart';
import 'package:newcairo/localization/language_constrants.dart';
import 'package:newcairo/util/app_constants.dart';
import 'package:newcairo/util/responsive.dart';
import 'package:newcairo/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../data/model/response/Product/product.dart';
import '../../provider/localization_provider.dart';
import '../../provider/theme_provider.dart';
import '../../util/color_resources.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../screen/product/product_details_screen.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) =>
                  ProductDetails(product: product),
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Container(
              height: 110,
              width: width(context),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                fit: BoxFit.cover,
                image: '${AppConstants.BASE_URL_IMAGE}${product.pavatar}',
                imageErrorBuilder: (c, o, s) =>
                    Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.PADDING_SIZE_SMALL,
                Dimensions.PADDING_SIZE_EXTRA_SMALL,
                Dimensions.PADDING_SIZE_SMALL,
                Dimensions.PADDING_SIZE_SMALL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      Provider.of<LocalizationProvider>(context)
                                  .locale!
                                  .languageCode ==
                              "en"
                          ? product.titleEn ?? "No Title"
                          : product.title ?? "لا يوجد عنوان",
                      style: cairoMedium.copyWith(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${product.price} ${getTranslated('currency', context)}",
                        style: cairoBold.copyWith(
                            color: ColorResources.getPrimary(context)),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    SizedBox(
                      width: 20,
                      child: Text(
                          product.rate != null
                              ? product.rate!.isNotEmpty
                                  ? double.parse(product.rate!)
                                      .toStringAsFixed(1)
                                  : '0.0'
                              : '0.0',
                          style: cairoRegular.copyWith(
                            color: Provider.of<ThemeProvider>(context).darkTheme
                                ? Colors.white
                                : Colors.orange,
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          )),
                    ),
                    Icon(Icons.star,
                        color: Provider.of<ThemeProvider>(context).darkTheme
                            ? Colors.white
                            : Colors.orange,
                        size: 15),
                  ]),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  product.priceBefore != null
                      ? Text(
                          "${product.priceBefore!} ${getTranslated('currency', context)}",
                          style: cairoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
