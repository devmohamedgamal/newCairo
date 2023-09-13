// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/data/model/response/area_model.dart';
import 'package:lemirageelevators/data/model/response/city_model.dart';
import 'package:lemirageelevators/data/model/response/governorate_model.dart';
import 'package:lemirageelevators/helper/get_translated_name.dart';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/spacer.dart';
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
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .highlightColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme
                      .of(context)
                      .highlightColor, boxShadow: [
                    BoxShadow(color: Colors.grey[Provider
                        .of<ThemeProvider>(context)
                        .darkTheme ? 700 : 200]!, spreadRadius: 1, blurRadius: 5)
                  ]),
                  child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
                ),
              ),
            ),

            Consumer<CartProvider>(
              builder: (context, cart, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Governorate
                    // area
                    // City
                    Text('Governorate'.tr(context), style: cairoBold),
                    _DropDownListBuilder<GovernorateModel>(
                      items: cart.shippingPlacesList,
                      title: 'Governorate'.tr(context),
                      index: cart.shippingPlacesIndex,
                      onChanged: (gov){
                        cart.getShippingCities(context, govIndex: cart.shippingPlacesList.indexOf(gov!));
                      },
                      itemBuilder: (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.getLocalizedName(context),
                            style: cairoRegular.copyWith(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                        );
                      },
                    ),
                    HSpacer(Dimensions.PADDING_SIZE_DEFAULT),
                    // City
                    Text('City'.tr(context), style: cairoBold),
                    _DropDownListBuilder<ShippingCityModel>(
                      items: cart.shippingCitiesList,
                      title: 'City'.tr(context),
                      index: cart.shippingCitiesIndex,
                      onChanged: (city){
                        cart.getShippingAreas(context, cityIndex: cart.shippingCitiesList.indexOf(city!));
                      },
                      isLoading: cart.isLoadingCities,
                      itemBuilder: (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.getLocalizedName(context),
                            style: cairoRegular.copyWith(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                        );
                      },
                    ),
                    HSpacer(Dimensions.PADDING_SIZE_DEFAULT),
                    // Area
                    Text('area'.tr(context), style: cairoBold),
                    _DropDownListBuilder<ShippingAreaModel>(
                      items: cart.shippingAreasList,
                      title: 'area'.tr(context),
                      index: cart.shippingAreasIndex,
                      onChanged: (area){
                        cart.setSelectedShippingAreaId(cart.shippingAreasList.indexOf(area!));
                      },
                      isLoading: cart.isLoadingAreas,
                      itemBuilder: (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.getLocalizedName(context),
                            style: cairoRegular.copyWith(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                        );
                      },
                    ),
                    HSpacer(Dimensions.PADDING_SIZE_DEFAULT),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DropDownListBuilder<Type> extends StatelessWidget {
  const _DropDownListBuilder({
    Key? key,
    required this.items,
    required this.title,
    required this.index,
    required this.onChanged,
    required this.itemBuilder,
    this.isLoading = false,
    this.selectedItemBuilder,
  }) : super(key: key);

  final List<Type> items;
  final String title;
  final int? index;
  final void Function(Type?)? onChanged;
  final DropdownMenuItem<Type> Function(Type e) itemBuilder;
  final bool isLoading;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 1), // changes position of shadow
          )
        ],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
      ),
      alignment: Alignment.center,
      child: DropdownButtonFormField<Type>(
        value: index == null ? null : items[index!],
        isExpanded: false,
        hint: Text('${'choose'.tr(context)} $title'),
        icon: Icon(
          Icons.keyboard_arrow_up_outlined,
          color: Theme
              .of(context)
              .primaryColor,
        ),
        decoration: InputDecoration(border: InputBorder.none),
        iconSize: 24,
        elevation: 16,
        style: cairoRegular,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<Type>>(itemBuilder).toList(),
        selectedItemBuilder: selectedItemBuilder,
      ),
    );
  }
}
