import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/no_internet_screen.dart';
import '../../baseWidget/product_shimmer.dart';
import '../../baseWidget/product_widget.dart';

class BrandAndCategoryProductScreen extends StatelessWidget {
  final String id;
  final String name;
  final String? image;
  const BrandAndCategoryProductScreen(
      {Key? key, required this.id, required this.name, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false)
        .initCategoryProductList(id, context);
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(title: name),
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                // Products
                productProvider.categoryProductList.isNotEmpty
                    ? Expanded(
                        child: StaggeredGridView.countBuilder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: productProvider.categoryProductList.length,
                          shrinkWrap: true,
                          staggeredTileBuilder: (int index) =>
                              const StaggeredTile.fit(1),
                          itemBuilder: (BuildContext context, int index) {
                            return ProductWidget(
                                product:
                                    productProvider.categoryProductList[index]);
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                        child: productProvider.hasData
                            ? ProductShimmer(
                                isHomePage: false,
                                isEnabled: Provider.of<ProductProvider>(context)
                                    .categoryProductList
                                    .isEmpty)
                            : NoInternetOrDataScreen(isNoInternet: false),
                      )),
              ]);
        },
      ),
    );
  }
}
