// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/product_widget.dart';
import '../../../baseWidget/title_row.dart';
import '../../product/view_all_product_screen.dart';

class ProductView extends StatelessWidget {
  final bool isHomePage;
  ProductView({required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, prodProvider, child) {
        return prodProvider.products.isNotEmpty ||
            prodProvider.products != null
            ? Column(children: [
              isHomePage
                  ? Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_LARGE,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: TitleRow(
                        title: getTranslated('featured_products', context)!,
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (_) => AllProductScreen()));
                        })
                )
                  : Container(),

                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: StaggeredGridView.countBuilder(
                      itemCount: isHomePage
                          ? prodProvider.products.length > 4
                          ? 4
                          : prodProvider.products.length
                          : prodProvider.products.length,
                      crossAxisCount: 2,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                            product: prodProvider.products[index]);
                      },
                    )),
              ])
            : SizedBox.shrink();
      },
    );
  }
}