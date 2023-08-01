// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/gallery_provider.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/view/baseWidget/custom_app_bar.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:lemirageelevators/view/screen/gallery/videos/video_player_screen.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/textStyle.dart';
import '../../../baseWidget/no_internet_screen.dart';

class VideosScreen extends StatefulWidget {
  final bool isBacButtonExist;
  VideosScreen({this.isBacButtonExist = true});
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}
class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
            title: getTranslated('videos_gallery', context)!,
            isBackButtonExist: widget.isBacButtonExist),
        Expanded(
          child: Consumer<GalleryProvider>(
            builder: (context, gallery, child) {
              return gallery.videosList.length != 0
                  ? RefreshIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                      onRefresh: () async {
                        await gallery.getVideosGallery(context);
                      },
                      child: ListView.builder(
                        itemCount: gallery.videosList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.fromLTRB(0,0,0,8),
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context)=> VideoPlayerScreen(
                                          video: gallery.videosList[index])));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 70.0,
                                          width: width(context) * 0.25,
                                          decoration: const BoxDecoration(
                                            color: Color(0xfff5f5f5),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(12)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(12)),
                                            child: YoutubePlayer(
                                              controller: YoutubePlayerController(
                                                initialVideoId:
                                                YoutubePlayer.convertUrlToId(
                                                    gallery.videosList[index]
                                                        .youtube!)!,
                                                flags: const YoutubePlayerFlags(
                                                  autoPlay: false,
                                                  enableCaption: false,
                                                  useHybridComposition: false,
                                                  captionLanguage: 'en',
                                                ),
                                              ),
                                              showVideoProgressIndicator: true,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 70.0,
                                          width: width(context) * 0.25,
                                          decoration: const BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(12)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Center(
                                              child: Icon(
                                                Icons.play_circle,
                                                color: ColorResources.BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    WSpacer(10),
                                    Container(
                                      width: width(context) * 0.65,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            gallery.videosList[index].title ?? "",
                                            style: cairoSemiBold.copyWith(
                                                fontSize: 15,
                                                color: ColorResources.BLACK),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            gallery.videosList[index]
                                                .description ??
                                                "",
                                            style: cairoRegular.copyWith(
                                                fontSize: 10,
                                                color: ColorResources.BLACK
                                                    .withOpacity(0.6)),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                            ),
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
                  Text(getTranslated("no_videos", context)!,style: cairoSemiBold),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}