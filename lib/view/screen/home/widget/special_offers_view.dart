// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/title_row.dart';
import '../../featureddeal/featured_deal_screen.dart';
import 'featured_deal_view.dart';

class SpecialOffersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return homeProvider.specialOffers != null ||
                homeProvider.specialOffers.isNotEmpty
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_LARGE,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: TitleRow(
                        title: getTranslated('featured_deals', context)!,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => FeaturedDealScreen()));
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Container(
                        height: 150,
                        child: FeaturedDealsView(isHomePage: true)),
                  )
                ],
              )
            : Container();
      },
    );
  }
}
