import 'package:newcairo/provider/theme_provider.dart';
import 'package:newcairo/util/color_resources.dart';
import 'package:newcairo/util/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  CustomButton({required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorResources.getChatIcon(context),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient:
                (Provider.of<ThemeProvider>(context).darkTheme || onTap == null)
                    ? null
                    : LinearGradient(colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor,
                      ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: cairoSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).highlightColor,
            )),
      ),
    );
  }
}
