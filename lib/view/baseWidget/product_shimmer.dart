import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:shimmer/shimmer.dart';
import '../../util/color_resources.dart';
import '../../util/dimensions.dart';

class ProductShimmer extends StatelessWidget {
  final bool isEnabled;
  final bool isHomePage;
  ProductShimmer({required this.isEnabled, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (1 / 1.5),
      ),
      itemCount: 8,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: height(context) * 0.2,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).highlightColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: isEnabled,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.getIconBg(context),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                    ),
                  ),

                  // Product Details
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 20, color: Colors.white),
                          const SizedBox(
                              height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Row(children: [
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 50,
                                        color: Colors.white),
                                  ]),
                            ),
                            Container(
                                height: 10, width: 50, color: Colors.white),
                            const Icon(Icons.star,
                                color: Colors.orange, size: 15),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
