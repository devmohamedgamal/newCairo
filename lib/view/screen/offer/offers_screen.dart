// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../localization/language_constrants.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/responsive.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/custom_expanded_app_bar.dart';

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
        title: getTranslated('offers', context)!,
        child: Consumer<HomeProvider>(
      builder: (context, offer, child) {
        return offer.sliders != null
            ? offer.sliders.length != 0
              ? ListView.builder(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            itemCount: offer.sliders.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _launchUrl(offer.sliders[index].link!),
                child: Container(
                  margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          fit: BoxFit.fill, height: 150,
                          width: width(context),
                          image: '${AppConstants.BASE_URL_IMAGE}${offer.sliders[index].avatar}',
                          imageErrorBuilder: (c, o, s) =>
                              Image.asset(Images.placeholder,
                              fit: BoxFit.fill,width: width(context), height: 150),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: ColorResources.GREY.withOpacity(0.3),
                          width: width(context),
                          child: Center(
                            child: Text(
                                offer.sliders[index].description ?? "",
                                style: cairoMedium.copyWith(color: ColorResources.BLACK),
                                maxLines: null,
                                textAlign:TextAlign.center
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              );
            },
          )
              : Center(child: Text('No banner available'))
            : OfferShimmer();
      },
    ));
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class OfferShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: Provider.of<HomeProvider>(context).sliders.isEmpty,
          child: Container(
            height: 100,
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE,
                vertical: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.WHITE),
          ),
        );
      },
    );
  }
}