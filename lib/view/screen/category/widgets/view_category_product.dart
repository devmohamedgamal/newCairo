import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:provider/provider.dart';
import '../../../baseWidget/product_shimmer.dart';
import '../../../baseWidget/product_widget.dart';

class ViewCategoryProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width(context) - 100,
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return productProvider.categoryProductList.length > 0
                ? StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              physics: AlwaysScrollableScrollPhysics(),
              crossAxisCount: 2,
              itemCount: productProvider.categoryProductList.length,
              shrinkWrap: true,
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(
                    product:
                    productProvider.categoryProductList[index]);
              },
            )
                : Center(
                child: ProductShimmer(
                    isHomePage: false,
                    isEnabled: Provider.of<ProductProvider>(context)
                        .categoryProductList
                        .length ==
                        0));
          },
        ));
  }
}
