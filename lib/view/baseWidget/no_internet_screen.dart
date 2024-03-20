import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:newcairo/util/textStyle.dart';
import '../../localization/language_constrants.dart';
import '../../util/color_resources.dart';
import '../../util/dimensions.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  final Widget? child;
  NoInternetOrDataScreen({required this.isNoInternet, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                isNoInternet
                    ? getTranslated('OPPS', context)
                    : getTranslated('sorry', context),
                style: cairoBold.copyWith(
                  fontSize: 30,
                  color: isNoInternet
                      ? Theme.of(context).textTheme.bodyLarge!.color
                      : ColorResources.getColombiaBlue(context),
                )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(
              isNoInternet
                  ? getTranslated('no_internet_connection', context)
                  : getTranslated('no_data', context),
              textAlign: TextAlign.center,
              style: cairoRegular,
            ),
            SizedBox(height: 40),
            isNoInternet
                ? Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorResources.getYellow(context)),
                    child: TextButton(
                      onPressed: () async {
                        if (await Connectivity().checkConnectivity() !=
                            ConnectivityResult.none) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => child!));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(getTranslated('RETRY', context),
                            style: cairoSemiBold.copyWith(
                                color: Theme.of(context).highlightColor,
                                fontSize: Dimensions.FONT_SIZE_LARGE)),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
