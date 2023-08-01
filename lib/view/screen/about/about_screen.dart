import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/localization_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../util/app_constants.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../baseWidget/custom_app_bar.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('about_us', context)!),
          Consumer<SplashProvider>(builder: (context, appInfo, child) {
            return Expanded(
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        fit: BoxFit.scaleDown,
                        width: width(context),
                        height: height(context) * 0.2,
                        image: '${AppConstants.BASE_URL_IMAGE}${appInfo.appInfo!.avatar}',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder,
                            fit: BoxFit.scaleDown,
                            width: width(context),
                            height: height(context) * 0.2),
                      ),

                      richText(getTranslated('company_name', context)!, appInfo.appInfo!.title!),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated('About_company', context)!,
                            style: cairoSemiBold.copyWith(color: ColorResources.ORANGE),
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          SizedBox(
                            // height: 100,
                            child: Html(data:
                            Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                ? appInfo.appInfo!.descriptionEn!
                                : appInfo.appInfo!.description!,
                              style: {
                                'h1': Style(color: Colors.red),
                                'p': Style(color: Colors.black87, fontSize: FontSize.medium),
                                'ul': Style(margin: const EdgeInsets.symmetric(vertical: 20))
                              },
                            ),
                          )
                        ],
                      ),

                      richText(getTranslated('services_provided_company', context)!, appInfo.appInfo!.tags!),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                      // addresses
                      lineText(getTranslated('company_addresses', context)!,context),
                      Text(" ـ " + appInfo.appInfo!.address!,
                        style: cairoSemiBold,
                      ),

                      appInfo.appInfo!.address2!.isEmpty  || appInfo.appInfo!.address2 == null
                          ? Container()
                          : Text(" ـ " + appInfo.appInfo!.address2!,
                        style: cairoSemiBold,
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                      // contact
                      lineText(getTranslated('contact_company', context)!,context),
                      Text(getTranslated('contact_numbers', context)!,
                        style: cairoSemiBold,
                      ),

                      appInfo.appInfo!.mobile!.isEmpty  || appInfo.appInfo!.mobile == null
                          ? Container()
                          : Text("       ـ      " + appInfo.appInfo!.mobile!,
                        style: cairoSemiBold.copyWith(color: ColorResources.BLUE),
                      ),
                      
                      appInfo.appInfo!.mobile2!.isEmpty  || appInfo.appInfo!.mobile2 == null
                          ? Container()
                          : Text("       ـ      " + appInfo.appInfo!.mobile2!,
                        style: cairoSemiBold.copyWith(color: ColorResources.BLUE),
                      ),

                      appInfo.appInfo!.phone!.isEmpty  || appInfo.appInfo!.phone == null
                          ? Container()
                          : Text("       ـ      " + appInfo.appInfo!.phone!,
                        style: cairoSemiBold.copyWith(color: ColorResources.BLUE),
                      ),

                      appInfo.appInfo!.phone2!.isEmpty  || appInfo.appInfo!.phone2 == null
                          ? Container()
                          : Text("       ـ      " + appInfo.appInfo!.phone2!,
                        style: cairoSemiBold.copyWith(color: ColorResources.BLUE),
                      ),

                      appInfo.appInfo!.hotline!.isEmpty  || appInfo.appInfo!.hotline == null
                          ? Container()
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated('hot_line', context)!,
                            style: cairoSemiBold
                          ),

                          Text("       ـ      " + appInfo.appInfo!.hotline!,
                            style: cairoSemiBold.copyWith(color: ColorResources.BLUE),
                          ),
                        ],
                      ),


                      /// social_media
                      lineText(getTranslated('social_media', context)!,context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () => _launchUrl(appInfo.appInfo!.facebook!),
                              icon: Icon(Icons.facebook,size: 40,color: ColorResources.BLUE)
                          ),

                          IconButton(
                              onPressed: () => _launchUrl(appInfo.appInfo!.whatsapp!),
                              icon: Icon(Icons.whatsapp,size: 40,color: ColorResources.GREEN)
                          ),

                          IconButton(
                              onPressed: () => _launchUrl(appInfo.appInfo!.email!),
                              icon: Image.asset(Images.gmail)
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () => _launchUrl(appInfo.appInfo!.youtube!),
                              icon: Image.asset(Images.youtube)
                          ),

                          IconButton(
                              onPressed: () => _launchUrl(appInfo.appInfo!.telegram!),
                              icon: Icon(Icons.telegram_outlined,size: 40,color: ColorResources.BLUE)
                          ),


                          IconButton(
                              onPressed: () => _launchUrl(appInfo.appInfo!.twitter!),
                              icon: Image.asset(Images.twitter)
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          }),
        ],
      ),
    );
  }

  Widget richText(String title, String description) {
    return RichText(
      text: TextSpan(
        text: title,
        style: cairoSemiBold.copyWith(color: ColorResources.ORANGE),
        children: [
          TextSpan(
              text: "   " + description,
              style: cairoRegular.copyWith(color: ColorResources.BLACK)),
        ],
      ),
    );
  }

  Widget lineText(String title, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: width(context)*0.25,
          height: 1,
          color: ColorResources.BLACK,
        ),
        Text(title,
          style: cairoSemiBold.copyWith(color: ColorResources.ORANGE),
        ),
        Container(
          width: width(context)*0.25,
          height: 1,
          color: ColorResources.BLACK,
        ),
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