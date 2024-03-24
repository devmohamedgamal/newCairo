import 'package:flutter/material.dart';
import 'package:newcairo/view/baseWidget/web_view_screen.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/theme_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../util/textStyle.dart';
import '../baseWidget/custom_expanded_app_bar.dart';
import '../baseWidget/dialog/animated_custom_dialog.dart';
import '../baseWidget/dialog/language_dialog.dart';
import '../baseWidget/dialog/sign_out_confirmation_dialog.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: CustomExpandedAppBar(
        title: getTranslated('settings', context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwitchListTile(
              value: Provider.of<ThemeProvider>(context).darkTheme,
              onChanged: (bool isActive) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
              title: Text(getTranslated('dark_theme', context),
                  style: cairoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            TitleButton(
              image: Images.language,
              title: getTranslated('choose_language', context),
              onTap: () => showAnimatedDialog(context, LanguageDialog()),
            ),
            TitleButton(
              image: Images.about,
              title: getTranslated('About', context),
              onTap: () => showAnimatedDialog(context, AboutWidget()),
            ),
            TitleButton(
              image: Images.about,
              title: getTranslated('Privacy Policy', context),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                          url:
                              'https://www.elbascet.com/newcairo/Website/policy'),
                    ));
              },
            ),
            Spacer(),
            Container(
              width: 160,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.exit_to_app,
                      color: ColorResources.getPrimary(context), size: 25),
                  title: Text(getTranslated('sign_out', context),
                      style: cairoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  onTap: () => showAnimatedDialog(
                      context, SignOutConfirmationDialog(),
                      isFlip: true),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Function() onTap;

  TitleButton({required this.image, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: ColorResources.getPrimary(context)),
      title: Text(title,
          style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap,
    );
  }
}

class AboutWidget extends StatelessWidget {
  const AboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).highlightColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Company name : New Cairo', style: cairoRegular),
            SizedBox(height: 10),
            Text('Developer name : Mohamed Gamal', style: cairoRegular),
            SizedBox(height: 10),
            Text('Version : 1.0.0 ', style: cairoRegular),
            SizedBox(height: 10),
            Text(
                'contact us :- \n Email : appnewcairo@gmail.com \n phone : +201023654681 ',
                style: cairoRegular),
          ],
        ),
      ),
    );
  }
}
