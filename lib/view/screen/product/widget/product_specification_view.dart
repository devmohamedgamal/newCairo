import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/title_row.dart';
import '../specification_screen.dart';

class ProductSpecification extends StatelessWidget {
  final String details;
  ProductSpecification({required this.details});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Column(
      children: [
        TitleRow(
            title: getTranslated('specification', context)!,
            isDetailsPage: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SpecificationScreen(details: details)));
            }),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        details.isNotEmpty
            ? SizedBox(
                height: 100,
                child: Html(data: details),
              )
            : Center(child: Text('No specification')),
      ],
    );
  }
}
