import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import '../../../../data/model/response/videos_model.dart';
import '../../../../localization/language_constrants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../util/responsive.dart';
import '../../../baseWidget/custom_app_bar.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;
  final bool isBacButtonExist;
  const VideoPlayerScreen({required this.video,this.isBacButtonExist = true});
  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}
class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
            title: getTranslated('videos_gallery', context)!,
            isBackButtonExist: widget.isBacButtonExist),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width(context),
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
                           widget.video.youtube!)!,
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

                Text(widget.video.title ?? "",
                    style: cairoBlack.copyWith(
                      color: ColorResources.BLACK,
                      fontSize: 15
                    )),
                Text(widget.video.description ?? "",
                    style: cairoRegular.copyWith(
                      color: ColorResources.BLACK.withOpacity(0.5),
                      fontSize: 14
                    )),
              ],
            ),
          )
        ),
      ]),
    );
  }
}