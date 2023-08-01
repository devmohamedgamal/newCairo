import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lemirageelevators/view/screen/search/widget/search_filter_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/home_model.dart';
import '../../../../provider/search_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/textStyle.dart';
import '../../../baseWidget/product_widget.dart';

class SearchProductWidget extends StatelessWidget {
  final bool? isViewScrollable;
  final List<Product>? products;
  SearchProductWidget({this.isViewScrollable, this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Search result for \"${Provider.of<SearchProvider>(context).searchText}\" (${products!.length} items)',
                  style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => showModalBottomSheet(context: context, isScrollControlled: true,
                    backgroundColor: Colors.transparent, builder: (c) => SearchFilterBottomSheet()),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    color: ColorResources.getLowGreen(context),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Theme.of(context).hintColor),
                  ),
                  child: Row(children: [
                       SvgPicture.asset(Images.filter_image, width: 10, height: 10,
                        color: ColorResources.getPrimary(context)),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text('Filter'),
                  ]),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: StaggeredGridView.countBuilder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              crossAxisCount: 2,
              itemCount: products!.length,
              //shrinkWrap: true,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(product: products![index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}