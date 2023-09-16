import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/view/screen/home/widget/featured_deal_view_screen.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../util/dimensions.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../home/widget/featured_deal_view.dart';
import '../../../provider/theme_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/textStyle.dart';
import '../home/widget/products_view.dart';

class FeaturedDealScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20, color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(getTranslated('featured_products', context)!,
            style: cairoRegular.copyWith(fontSize: 18, color: ColorResources.WHITE)),

      ),

      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {

          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: FeaturedDealsViewFullScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: getTranslated('featured_deals', context)),

        Expanded(child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Provider.of<HomeProvider>(context, listen: false).getHomeData(true, context);
          },

          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: FeaturedDealsView(isHomePage: false),
          ),
        )),
      ]),
    );
  }
}