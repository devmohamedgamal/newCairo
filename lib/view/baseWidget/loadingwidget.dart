import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loadingWidget extends StatelessWidget {
  const loadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
