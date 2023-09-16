// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../screen/auth/auth_screen.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String? errorText;

  const ErrorAlertDialog({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
            child: Text(errorText ?? 'error_occurred'.tr(context), style: cairoBold, textAlign: TextAlign.center),
          ),
          Divider(height: 1, color: ColorResources.HINT_TEXT_COLOR),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
                    child: Text(getTranslated('ok', context), style: cairoBold.copyWith(color: Theme.of(context).primaryColor)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
