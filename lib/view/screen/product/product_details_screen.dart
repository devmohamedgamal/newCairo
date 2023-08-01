import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/product/widget/bottom_cart_view.dart';
import 'package:lemirageelevators/view/screen/product/widget/product_image_view.dart';
import 'package:lemirageelevators/view/screen/product/widget/product_specification_view.dart';
import 'package:lemirageelevators/view/screen/product/widget/product_title_view.dart';
import 'package:lemirageelevators/view/screen/product/widget/product_variants_view.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/home_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/localization_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../provider/wishlist_provider.dart';
import '../../../util/dimensions.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false)
        .getDetailsProduct(context,
        Provider.of<AuthProvider>(context, listen: false).user == null
            ? ""
            : Provider.of<AuthProvider>(context, listen: false).user!.userId!,
        product.id!);
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<WishProvider>(context, listen: false)
          .checkWishList(product.id.toString(),
          Provider.of<AuthProvider>(context, listen: false).user!.userId!, context);
    }

    return Consumer<ProductProvider>(
      builder: (context, details, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    size: 20),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(getTranslated('product_details', context)!,
                  style: cairoRegular.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText1!.color)),
            ]),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : Colors.white.withOpacity(0.5),
          ),
          body: ListView(
            shrinkWrap: true,
            // physics: BouncingScrollPhysics(),
            children: [
              // images && favourites
              details.detailsProduct == null
                  ? Container()
                  : ProductImageView(detailsProduct: details.detailsProduct!),

              // Title && price && share && rate
              ProductTitleView(product: product),

              // Specification
              product.details != null && product.details!.isNotEmpty
                  ? Container(
                margin:
                EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).highlightColor,
                child: ProductSpecification(
                    details: Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                        ? product.detailsEn ?? ''
                        : product.details ?? ''
                ),
              )
                  : SizedBox(),

              // Product variant
              details.detailsProduct == null ||
                  details.detailsProduct!.fetchedProductSize == null
                  ? SizedBox()
                  : Container(
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    color: Theme.of(context).highlightColor,
                    child: ProductVariants(
                    details: details.detailsProduct!
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomCartView(product: product),
        );
      },
    );
  }
}