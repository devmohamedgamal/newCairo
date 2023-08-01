import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/albums_model.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import 'album_images_view.dart';

class AlbumDetails extends StatelessWidget {
  final Albums albums;
  AlbumDetails({required this.albums});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 20),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
              ? albums.information![0].titleEn!
              : albums.information![0].title!,
              style: cairoRegular.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1!.color)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Colors.white.withOpacity(0.5),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          // images && favourites
          AlbumImagesView(
            photos: albums.photo,
            title: Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                  ? albums.information![0].titleEn!
                  : albums.information![0].title!,
          ),

          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
            Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                ? albums.information![0].descriptionEN!
                : albums.information![0].description!,
            style: cairoBold.copyWith(
                color: ColorResources.getPrimary(context),
                fontSize: Dimensions.FONT_SIZE_LARGE),
          ),
          )

        ],
      ),
    );
  }
}