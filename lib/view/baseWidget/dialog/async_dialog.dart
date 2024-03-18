// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, use_key_in_widget_constructors, must_be_immutable
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AsyncDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: ColorResources.GREY,
                    size: 60,
                  ),
              ),
            ),

            HSpacer(10),

            Text(getTranslated("async", context)!,
                style: cairoRegular.copyWith(
                    color: ColorResources.WHITE,
                  fontSize: 18
                )),

      ]),
    );
  }
}