// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/provider/cart_provider.dart';
import 'package:lemirageelevators/view/screen/cart/widget/suggested_product_item_widget.dart';
import 'package:lemirageelevators/view/screen/home/widget/featured_deal_view.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/title_row.dart';
import '../../featureddeal/featured_deal_screen.dart';

class SuggestedProductsWidget extends StatefulWidget {
  @override
  State<SuggestedProductsWidget> createState() => _SuggestedProductsWidgetState();
}

class _SuggestedProductsWidgetState extends State<SuggestedProductsWidget> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _getSuggestions();
    });
    super.initState();
  }

  Future<void> _getSuggestions() async {
    final clientId = await Provider.of<AuthProvider>(context, listen: false).user!.userId!;
    Provider.of<CartProvider>(context, listen: false).getSuggestedProducts(clientId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        if(cartProvider.suggestedProducts.isEmpty){
          return SizedBox.shrink();
        }

        return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_LARGE,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: TitleRow(
                        title: getTranslated('suggested_products', context),
                      // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (_) => FeaturedDealScreen()));
                        // },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Container(
                        height: 150,
                        child: SuggestedProductItemWidget(),
                    ),
                  )
                ],
              );
      },
    );
  }
}
