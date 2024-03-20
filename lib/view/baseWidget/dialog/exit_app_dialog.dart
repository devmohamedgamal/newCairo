// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, deprecated_member_use
import 'dart:io';
import 'package:newcairo/localization/language_constrants.dart';
import 'package:newcairo/util/color_resources.dart';
import 'package:newcairo/view/baseWidget/spacer.dart';
import 'package:flutter/material.dart';

class ExitPopUp extends StatelessWidget {
  final Widget child;
  final Function() setPage;
  ExitPopUp({required this.child, required this.setPage});
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopUp() async {
      setPage();
      return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          title: Row(
            children: [
              Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              WSpacer(5),
              Text(
                getTranslated("exit1", context),
                style: TextStyle(
                    color: ColorResources.GREEN,
                    fontSize: 16,
                    fontFamily: "Cairo_Black"),
              ),
            ],
          ),
          content: Text(
            getTranslated("exit", context),
            style: TextStyle(
                color: ColorResources.BLACK,
                fontSize: 14,
                fontFamily: "Cairo_Black"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text(
                getTranslated("ok1", context),
                style: TextStyle(
                    color: ColorResources.BLACK,
                    fontSize: 15,
                    fontFamily: "Cairo_Black"),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                getTranslated("no", context),
                style: TextStyle(
                    color: ColorResources.RED,
                    fontSize: 15,
                    fontFamily: "Cairo_Black"),
              ),
            ),

            // FlatButton(
            //   shape: StadiumBorder(),
            //   color: Colors.black12,
            // ),
            // FlatButton(
            //   shape: StadiumBorder(),
            //   color: Colors.black12,
            // ),
          ],
        ),
      );
    }

    return WillPopScope(child: child, onWillPop: showExitPopUp);
  }
}
