// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/dimensions.dart';

class ShippingMethodBottomSheet extends StatefulWidget {
  final int index;
  ShippingMethodBottomSheet({required this.index});
  @override
  _ShippingMethodBottomSheetState createState() => _ShippingMethodBottomSheetState();
}
class _ShippingMethodBottomSheetState extends State<ShippingMethodBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Close Button
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).highlightColor,
                  boxShadow: [BoxShadow(
                      color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200]!,
                      spreadRadius: 1, blurRadius: 5)]),
              child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
            ),
          ),
        ),

        Consumer<CartProvider>(
          builder: (context, cart, child) {
            return cart.shippingPlacesList.isNotEmpty
                ? SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: cart.shippingPlacesList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        title: Text(
                            Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                                ? '${cart.shippingPlacesList[index].english} '
                                '(Cost: ${cart.shippingPlacesList[index].price})'
                                : '${cart.shippingPlacesList[index].arabic} '
                                '(السعر: ${cart.shippingPlacesList[index].price})'
                        ),
                        value: index,
                        groupValue: widget.index,
                        activeColor: Theme.of(context).primaryColor,
                        toggleable: false,
                        onChanged: (value) async {
                          var oldIndex = Provider.of<CartProvider>(context,
                              listen: false).shippingPlacesIndex;
                          Provider.of<CartProvider>(context,
                              listen: false).setSelectedShippingPlacesId(value,oldIndex);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                )
                : Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
          },
        ),
      ]),
    );
  }
}