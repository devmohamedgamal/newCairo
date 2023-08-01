import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../data/model/response/home_model.dart';
import '../../provider/localization_provider.dart';
import '../../provider/theme_provider.dart';
import '../../util/color_resources.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../screen/product/product_details_screen.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  ProductWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => 
              ProductDetails(product: product),
        ));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder, fit: BoxFit.cover,
                image: '${AppConstants.BASE_URL_IMAGE}${product.pavatar}',
                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.fromLTRB(
                  Dimensions.PADDING_SIZE_SMALL,
                  Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  Dimensions.PADDING_SIZE_SMALL,
                  Dimensions.PADDING_SIZE_SMALL,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                            ? product.titleEn ?? ""
                            : product.title ?? "",
                        style: cairoMedium.copyWith(fontSize: 12),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Row(children: [
                      Text(product.price.toString() + " \$",
                        style: cairoBold.copyWith(
                            color: ColorResources.getPrimary(context)),
                      ),

                      Expanded(child: SizedBox.shrink()),

                      Text(product.rate != null
                          ? product.rate!.length != 0 
                             ? double.parse(product.rate!).toStringAsFixed(1)
                              : '0.0'
                          : '0.0',
                          style: cairoRegular.copyWith(
                            color: Provider.of<ThemeProvider>(context).darkTheme
                                ? Colors.white
                                : Colors.orange,
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          )),

                      Icon(Icons.star,
                          color: Provider.of<ThemeProvider>(context).darkTheme
                              ? Colors.white : Colors.orange, size: 15),
                    ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    product.priceBefore != null
                        ? Text(
                      product.priceBefore! + " \$",
                      style: cairoBold.copyWith(
                        color: Theme.of(context).hintColor,
                        decoration: TextDecoration.lineThrough,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      ),
                    )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}