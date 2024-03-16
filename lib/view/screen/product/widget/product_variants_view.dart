// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../../../../localization/language_constrants.dart';
// import '../../../../provider/localization_provider.dart';
// import '../../../../util/color_resources.dart';
// import '../../../../util/textStyle.dart';
// import '../../../baseWidget/spacer.dart';

// class ProductVariants extends StatelessWidget {
//   const ProductVariants({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(getTranslated("product_variants", context, style: cairoBold),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: (Provider.of<LocalizationProvider>(context)
//                           .locale!
//                           .languageCode ==
//                       "en"
//                   ? details.fetchedProductSizeEN!
//                   : details.fetchedProductSize!)
//               .keys
//               .map((key) => Padding(
//                     padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         key.contains("#")
//                             ? Row(
//                                 children: [
//                                   Text(
//                                       getTranslated(
//                                               "color_variants", context)! +
//                                           key.toString(),
//                                       style: cairoBold),
//                                   Container(
//                                     width: 25,
//                                     height: 25,
//                                     margin: EdgeInsets.only(right: 10),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: Colors.grey),
//                                     child: Center(
//                                       child: Container(
//                                           width: 20,
//                                           height: 20,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(50),
//                                               color: Color(int.parse(
//                                                   "0xfff${key.toString().replaceAll("#", "")}")))),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : Text(
//                                 getTranslated("variants", context)! +
//                                     key.toString(),
//                                 textAlign: TextAlign.right,
//                                 style: cairoBold),
//                         HSpacer(5),
//                         Column(
//                             children: (Provider.of<LocalizationProvider>(
//                                                 context)
//                                             .locale!
//                                             .languageCode ==
//                                         "en"
//                                     ? details.fetchedProductSizeEN!
//                                     : details.fetchedProductSize!)[key]!
//                                 .map(
//                                   (item) => Padding(
//                                     padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                                     child: Container(
//                                       padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
//                                       decoration: BoxDecoration(
//                                           color: ColorResources.GREY,
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Text(
//                                                   item.color == null ||
//                                                           item.color!.isEmpty
//                                                       ? " "
//                                                       : item.color.toString(),
//                                                   style: cairoBold.copyWith(
//                                                       color: ColorResources
//                                                           .BLACK)),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                       getTranslated(
//                                                               "product_price",
//                                                               context)! +
//                                                           " :  ",
//                                                       style: cairoBold),
//                                                   Text(
//                                                       item.price! +
//                                                           " ${getTranslated('currency', context)}",
//                                                       textAlign:
//                                                           TextAlign.right,
//                                                       style: cairoBold.copyWith(
//                                                           color: Colors.black)),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           Text(item.qnt.toString() + " x",
//                                               textAlign: TextAlign.center,
//                                               style: cairoBold.copyWith(
//                                                   color: ColorResources.BLACK
//                                                       .withOpacity(0.4))),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                                 .toList()),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         )
//       ],
//     );
//   }
// }
