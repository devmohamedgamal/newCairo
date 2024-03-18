import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/Product/product.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/product/widget/product_image_view.dart';
import 'package:lemirageelevators/view/screen/product/widget/product_title_view.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../util/dimensions.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).user == null
        ? ""
        : Provider.of<AuthProvider>(context, listen: false).user!.userId!;
    return Consumer<ProductProvider>(
      builder: (context, details, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    size: 20),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(getTranslated('التفاصيل', context),
                  style: cairoRegular.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyLarge!.color)),
            ]),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : Colors.white.withOpacity(0.5),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              ProductImageView(product: product),
              // Title && price && share && rate
              ProductTitleView(product: product),
              Divider(
                thickness: 2,
                color: Colors.blue,
                endIndent: 20,
                indent: 20,
              ),
              SizedBox(height: 10),
                           Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  product.description!,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
