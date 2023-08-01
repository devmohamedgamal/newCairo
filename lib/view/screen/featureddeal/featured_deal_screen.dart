import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../util/dimensions.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../home/widget/featured_deal_view.dart';

class FeaturedDealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: getTranslated('featured_deals', context)!),

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