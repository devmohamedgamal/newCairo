// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, use_key_in_widget_constructors, must_be_immutable
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/localization_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageDialog extends StatelessWidget {
  int? index = 1;

  @override
  Widget build(BuildContext context) {
    List<String> _valueList = [];
    AppConstants.languages!.forEach((language) => _valueList.add(language.languageName));
    return Dialog(
      backgroundColor: Theme.of(context).highlightColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(getTranslated('language', context)!,
                  textAlign: TextAlign.center,
                  style: cairoSemiBold.copyWith(fontSize: 16)),
            ),

            SizedBox(
                height: 150,
                child: CupertinoPicker(
                  itemExtent: 40,
                  useMagnifier: true,
                  magnification: 1.2,
                  scrollController: FixedExtentScrollController(initialItem: index!),
                  onSelectedItemChanged: (int i) {
                    index = i;
                  },
                  children: _valueList.map((value) {
                    return Center(child: Text(value,
                        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)));
                  }).toList(),
                )),

            Divider(height: 5,
                color: ColorResources.WHITE),

            Row(children: [
              Expanded(child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(getTranslated('CANCEL', context)!
                    , style: cairoRegular.copyWith(color: ColorResources.RED)),
              )),

              Container(
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: VerticalDivider(width: 5, color: Theme.of(context).hintColor),
              ),

              Expanded(child: TextButton(
                onPressed: () async {
                    await Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                      AppConstants.languages![index!].languageCode,
                      AppConstants.languages![index!].countryCode,
                    ));
                    Navigator.pop(context);
                },
                child: Text(getTranslated('ok', context)!,
                    style: cairoRegular.copyWith(color: ColorResources.GREEN)),
              )),
            ]),

      ]),
    );
  }
}