import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/textStyle.dart';
import '../../product/product_details_screen.dart';

class FeaturedDealsView extends StatelessWidget {
  final bool isHomePage;
  FeaturedDealsView({required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return Provider.of<HomeProvider>(context).specialOffers.length != 0
            ? ListView.builder(
                padding: EdgeInsets.all(0),
                scrollDirection: isHomePage ? Axis.horizontal : Axis.vertical,
                itemCount: homeProvider.specialOffers.length == 0
                    ? 2
                    : homeProvider.specialOffers.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (context, anim1, anim2) =>
                                ProductDetails(
                                    product: homeProvider.specialOffers[index]),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: width(context) * 0.6,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).highlightColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ]),
                      child: Stack(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorResources.getIconBg(context),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    fit: BoxFit.cover,
                                    image: '${AppConstants.BASE_URL_IMAGE}'
                                        '${homeProvider.specialOffers[index].pavatar}',
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                        Images.placeholder,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                            ? homeProvider
                                            .specialOffers[index].titleEn!
                                            : homeProvider
                                            .specialOffers[index].title!,
                                        style: cairoSemiBold,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),

                                      Text(
                                        homeProvider
                                            .specialOffers[index].price! + " \$",
                                        style: cairoBold.copyWith(
                                            color: ColorResources.getPrimary(
                                                context)),
                                      ),

                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),

                                      Row(children: [
                                        Expanded(
                                          child: Text(
                                            homeProvider.specialOffers[index]
                                                        .priceBefore !=
                                                    null
                                                ? homeProvider
                                                    .specialOffers[index]
                                                    .priceBefore! + " \$"
                                                : "",
                                            style: cairoBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_EXTRA_SMALL,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          homeProvider.specialOffers[index]
                                                      .rate !=
                                                  null
                                              ? double.parse(homeProvider
                                                      .specialOffers[index]
                                                      .rate!)
                                                  .toString()
                                              : '0.0',
                                          style: cairoBold.copyWith(
                                              color: Provider.of<ThemeProvider>(
                                                          context)
                                                      .darkTheme
                                                  ? Colors.white
                                                  : Colors.orange,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                        ),
                                        Icon(Icons.star,
                                            color: Provider.of<ThemeProvider>(
                                                        context)
                                                    .darkTheme
                                                ? Colors.white
                                                : Colors.orange,
                                            size: 15),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ]),
                    ),
                  );
                },
              )
            : MegaDealShimmer();
      },
    );
  }
}

class MegaDealShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.WHITE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5)
              ]),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled:
                Provider.of<HomeProvider>(context).specialOffers.length == 0,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.ICON_BG,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, color: ColorResources.WHITE),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 20,
                                      width: 50,
                                      color: ColorResources.WHITE),
                                ]),
                          ),
                          Container(
                              height: 10,
                              width: 50,
                              color: ColorResources.WHITE),
                          Icon(Icons.star, color: Colors.orange, size: 15),
                        ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}