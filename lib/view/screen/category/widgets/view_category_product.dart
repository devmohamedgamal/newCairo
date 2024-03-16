import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:provider/provider.dart';
import '../../../baseWidget/product_shimmer.dart';
import '../../../baseWidget/product_widget.dart';

class ViewCategoryProduct extends StatelessWidget {
  const ViewCategoryProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        child: SafeArea(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  return productProvider.allProduct.isNotEmpty
                      ? StaggeredGridView.countBuilder(
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: productProvider.allProduct.length,
                          shrinkWrap: true,
                          staggeredTileBuilder: (int index) =>
                              const StaggeredTile.fit(1),
                          itemBuilder: (BuildContext context, int index) {
                            return ProductWidget(
                                product: productProvider.allProduct[index]);
                          },
                        )
                      : Center(
                          child: ProductShimmer(
                              isHomePage: false,
                              isEnabled: Provider.of<ProductProvider>(context)
                                  .categoryProductList
                                  .isEmpty));
                },
              )),
        ),
      ),
    );
  }
}
