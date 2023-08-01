import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lemirageelevators/provider/search_provider.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/search/widget/search_product_widget.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../baseWidget/no_internet_screen.dart';
import '../../baseWidget/product_shimmer.dart';
import '../../baseWidget/search_widget.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // for tool bar
          SearchWidget(
            hintText: getTranslated('SEARCH_HINT', context)!,
            onSubmit: (String text) {
              Provider.of<SearchProvider>(context, listen: false).searchProduct(text, context);
              Provider.of<SearchProvider>(context, listen: false).saveSearchAddress(text);
            },
            onClearPressed: () {
              Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
            },
            onTextChanged: (String query) {  },
          ),

          Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              return !searchProvider.isClear
                  ? searchProvider.searchProductList != null
                   ? searchProvider.searchProductList!.length > 0
                    ? Expanded(child: SearchProductWidget(
                      products: searchProvider.searchProductList!, isViewScrollable: true))
                    : Expanded(child: NoInternetOrDataScreen(isNoInternet: false))
                   : Expanded(child: ProductShimmer(isHomePage: false,
                     isEnabled: Provider.of<SearchProvider>(context).searchProductList == null))
                  : Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Consumer<SearchProvider>(
                        builder: (context, searchProvider, child) => StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: searchProvider.historyList.length,
                          itemBuilder: (context, index) => Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Provider.of<SearchProvider>(context,
                                      listen: false).searchProduct(searchProvider.historyList[index],
                                      context);
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorResources.getGrey(context)),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      Provider.of<SearchProvider>(context,
                                          listen: false).historyList[index],
                                      style: cairoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                    ),
                                  ),
                                ),
                              )),
                          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                      ),
                      Positioned(
                        top: -5,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTranslated('SEARCH_HISTORY', context)!, style: cairoBold),
                            InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Provider.of<SearchProvider>(context,
                                      listen: false).clearSearchAddress();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      getTranslated('REMOVE', context)!,
                                      style: cairoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context).primaryColor),
                                    ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}