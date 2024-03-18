import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/Product/product.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/responsive.dart';

class ProductImageView extends StatelessWidget {
  ProductImageView({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[
                      Provider.of<ThemeProvider>(context).darkTheme
                          ? 700
                          : 300]!,
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
            gradient: Provider.of<ThemeProvider>(context).darkTheme
                ? null
                : const LinearGradient(
                    colors: [ColorResources.WHITE, ColorResources.IMAGE_BG],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.width - 120,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                height: width(context),
                width: width(context),
                image: '${AppConstants.BASE_URL_IMAGE}'
                    '${product.pavatar}',
                imageErrorBuilder: (c, o, s) => Image.asset(
                  Images.placeholder,
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
