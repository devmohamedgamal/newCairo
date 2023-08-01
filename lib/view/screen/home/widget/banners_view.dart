// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/textStyle.dart';

class BannersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            double _width = MediaQuery.of(context).size.width;
            return homeProvider.sliders != null
                ? homeProvider.sliders.length != 0
                    ? Container(
                        width: _width,
                        height: _width * 0.32,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                viewportFraction: .95,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                disableCenter: true,
                                onPageChanged: (index, reason) {
                                  homeProvider.setCurrentIndex(index);
                                },
                              ),
                              itemCount: homeProvider.sliders.length == 0
                                  ? 1
                                  : homeProvider.sliders.length,
                              itemBuilder: (context, index, _) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder,
                                        fit: BoxFit.cover,
                                        image: '${AppConstants.BASE_URL_IMAGE}'
                                            '${homeProvider.sliders[index].avatar}',
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(Images.placeholder,
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: 5,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: homeProvider.sliders.map((banner) {
                                  int index =
                                      homeProvider.sliders.indexOf(banner);
                                  return TabPageSelectorIndicator(
                                    backgroundColor:
                                        index == homeProvider.currentIndex
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                    borderColor:
                                        index == homeProvider.currentIndex
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                    size: 10,
                                  );
                                }).toList(),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: ColorResources.GREY.withOpacity(0.4),
                                width: width(context),
                                child: Center(
                                  child: Text(
                                      Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                          ? homeProvider
                                          .sliders[
                                      homeProvider.currentIndex!]
                                          .descriptionEn ?? ""
                                          :
                                      homeProvider
                                              .sliders[
                                                  homeProvider.currentIndex!]
                                              .description ?? "",
                                      style: cairoMedium,
                                      maxLines: null,
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: homeProvider.sliders == null,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorResources.WHITE,
                        )),
                  );
          },
        ),

        // SizedBox(height: 5),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 9.0),
        //   child: Consumer<HomeProvider>(
        //     builder: (context, footerBannerProvider, child) {
        //       return footerBannerProvider.footerBannerList!=null && footerBannerProvider.footerBannerList.length != 0 ? GridView.builder(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //           childAspectRatio: (2/1),
        //         ),
        //         itemCount: footerBannerProvider.footerBannerList.length,
        //         shrinkWrap: true,
        //         physics: NeverScrollableScrollPhysics(),
        //         itemBuilder: (BuildContext context, int index) {
        //
        //           return InkWell(
        //             onTap: () => _launchUrl(footerBannerProvider.footerBannerList[index].url),
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //               child: Container(
        //                 decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
        //                 child: ClipRRect(
        //                   borderRadius: BorderRadius.all(Radius.circular(5)),
        //                   child: FadeInImage.assetNetwork(
        //                     placeholder: Images.placeholder, fit: BoxFit.cover,
        //                     image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl}'
        //                         '/${footerBannerProvider.footerBannerList[index].photo}',
        //                     imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           );
        //
        //         },
        //       )
        //
        //           : Shimmer.fromColors(
        //       baseColor: Colors.grey[300]!,
        //       highlightColor: Colors.grey[100]!,
        //       enabled: footerBannerProvider.footerBannerList == null,
        //       child: Container(margin: EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: ColorResources.WHITE,
        //       )),
        //       );
        //
        //     },
        //   ),
        // )
      ],
    );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
