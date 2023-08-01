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
  BrandAndCategoryProductScreen({required this.id,required this.name,this.image});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context,listen: false).initCategoryProductList(id,context);
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CustomAppBar(title: name),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            // Products
            productProvider.categoryProductList.length > 0
                ? Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                itemCount: productProvider.categoryProductList.length,
                shrinkWrap: true,
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(product: productProvider.categoryProductList[index]);
                },
              ),
            )
                : Expanded(
                  child: Center(
                    child: productProvider.hasData
                       ? ProductShimmer(isHomePage: false,
                     isEnabled: Provider.of<ProductProvider>(context).categoryProductList.length == 0)
                       : NoInternetOrDataScreen(isNoInternet: false),
            )),
          ]);
        },
      ),
    );
  }
}