// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/gallery_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/view/baseWidget/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/notification_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/textStyle.dart';
import '../../../baseWidget/read_more_text.dart';
import '../../../baseWidget/spacer.dart';
import 'album_details_screen.dart';

class AlbumsScreen extends StatelessWidget {
  final bool isBacButtonExist;
  AlbumsScreen({this.isBacButtonExist = true});

  @override
  Widget build(BuildContext context) {
    Provider.of<GalleryProvider>(context, listen: false)
        .getAlbumsGallery(context);
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
            title: getTranslated('photos_gallery', context)!,
            isBackButtonExist: isBacButtonExist),
        Expanded(
          child: Consumer<GalleryProvider>(
            builder: (context, gallery, child) {
              return gallery.albums != null && gallery.albums!.information!.length != 0
                      ? RefreshIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                          onRefresh: () async {
                            await gallery.getAlbumsGallery(context);
                          },
                          child: ListView.builder(
                            itemCount: gallery.albums!.information!.length,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>AlbumDetails(albums: gallery.albums!)));
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.PADDING_SIZE_SMALL,
                                        right: Dimensions.PADDING_SIZE_SMALL,
                                        left: Dimensions.PADDING_SIZE_SMALL,
                                    ),
                                    decoration: BoxDecoration(
                                        color: ColorResources.getGrey(context),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          height: height(context)*0.2,
                                          width: width(context),
                                          fit: BoxFit.cover,
                                          image: '${AppConstants.BASE_URL_IMAGE}${gallery.albums!.information![index].avatar}',
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(Images.placeholder,
                                                  height: height(context)*0.2,
                                                  width: width(context),
                                                  fit: BoxFit.cover),
                                        ),

                                        Padding(
                                            padding: EdgeInsets.fromLTRB(8, 5, 10, 0),
                                          child: Text(
                                              Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                                  ? gallery.albums!.information![index].titleEn!
                                                  : gallery.albums!.information![index].title!,
                                              style: cairoBold.copyWith(
                                                fontSize:
                                                Dimensions.FONT_SIZE_SMALL,
                                              )),
                                        ),

                                        Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 8),
                                          child: ReadMoreText(
                                            Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                                ? gallery.albums!.information![index].descriptionEN!
                                                : gallery.albums!.information![index].description!,
                                            trimLines: 2,
                                            textDirection: TextDirection.ltr,
                                            colorClickableText: Colors.amber,
                                            locale: Provider.of<LocalizationProvider>(context).locale,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: getTranslated("read_more", context)!,
                                            trimExpandedText: getTranslated("read_less", context)!,
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        )
                      : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Images.video_player,
                      width: width(context)*0.5,height: height(context)*0.1),
                  HSpacer(15),
                  Text(getTranslated("no_albums", context)!,style: cairoSemiBold),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled:
                Provider.of<NotificationProvider>(context).notificationList ==
                    null,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.WHITE),
              subtitle:
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
            ),
          ),
        );
      },
    );
  }
}
