import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import '../../util/dimensions.dart';

class AmountWidget extends StatelessWidget {
  final String title;
  final String amount;

  AmountWidget({required this.title,required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: cairoRegular.copyWith(
            fontSize: Dimensions.FONT_SIZE_SMALL)),
        Text(amount, style: cairoRegular.copyWith(
            fontSize: Dimensions.FONT_SIZE_SMALL)),
      ]),
    );
  }
}