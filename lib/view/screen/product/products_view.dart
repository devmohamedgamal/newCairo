// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/dimensions.dart';
import '../../../provider/product_provider.dart';
import '../../baseWidget/product_widget.dart';
import '../../baseWidget/title_row.dart';
import 'view_all_product_screen.dart';

class ProductView extends StatelessWidget {
  final bool isHomePage;
  const ProductView({Key? key, required this.isHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        return prodProvider.allProduct.isNotEmpty || prodProvider.allProduct != null
            ? Column(children: [
                isHomePage
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Dimensions.PADDING_SIZE_SMALL,
                            Dimensions.PADDING_SIZE_LARGE,
                            Dimensions.PADDING_SIZE_SMALL,
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: TitleRow(
                            title: getTranslated('featured_products', context),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AllProductScreen()));
                            }))
                    : Container(),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: StaggeredGridView.countBuilder(
                      itemCount: isHomePage
                          ? prodProvider.allProduct.length > 4
                              ? 4
                              : prodProvider.allProduct.length
                          : prodProvider.allProduct.length,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      staggeredTileBuilder: (int index) =>
                          const StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                            product: prodProvider.allProduct[index]);
                      },
                    )),
              ])
            : const SizedBox.shrink();
      },
    );
  }
}
