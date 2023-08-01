// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:lemirageelevators/util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color color;
  final double top;
  final double bottom;
  const Line({required this.color,required this.top,required this.bottom});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20,top,20,bottom),
      child: Container(
        width: width(context),
        height: 1,
        color: color,
      ),
    );
  }
}