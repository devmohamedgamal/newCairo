import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/product_widget.dart';
import '../../../baseWidget/title_row.dart';
import '../../product/view_all_product_screen.dart';

class FeaturedDealsViewFullScreen extends StatelessWidget {
  // final bool isHomePage;
  FeaturedDealsViewFullScreen();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, prodProvider, _) {
        return prodProvider.specialOffers.isNotEmpty == true
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: StaggeredGridView.countBuilder(
                      itemCount: prodProvider.specialOffers.length,
                      crossAxisCount: 2,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(product: prodProvider.specialOffers[index]);
                      },
                    ),
                  ),
                ],
              )
            : SizedBox.shrink();
      },
    );
  }
}
