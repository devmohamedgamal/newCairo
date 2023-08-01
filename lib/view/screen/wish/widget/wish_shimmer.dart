// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../util/color_resources.dart';

class WishShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: Provider.of<WishProvider>(context).allWishList == null,
          child: ListTile(
            leading:
            Container(height: 50, width: 50, color: ColorResources.WHITE),
            title: Container(height: 20, color: ColorResources.WHITE),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 10, width: 70, color: ColorResources.WHITE),
                  Container(height: 10, width: 20, color: ColorResources.WHITE),
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
                ]),
            trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: ColorResources.WHITE)),
                  SizedBox(height: 10),
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
                ]),
          ),
        );
      },
    );
  }
}