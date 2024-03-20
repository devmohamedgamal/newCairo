import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newcairo/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/textStyle.dart';
import '../../../baseWidget/product_shimmer.dart';
import '../../../baseWidget/product_widget.dart';

class ViewCategoryProduct extends StatelessWidget {
  const ViewCategoryProduct({Key? key, required this.category})
      : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyLarge!.color, size: 20),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(getTranslated(category, context),
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
