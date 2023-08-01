// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Color color;
  CircularButton({required this.color});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color)
      ),
    );
  }
}