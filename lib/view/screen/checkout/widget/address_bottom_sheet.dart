// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../baseWidget/button/custom_button.dart';
import '../../address/widget/add_address_bottom_sheet.dart';

class AddressBottomSheet extends StatelessWidget {
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
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).highlightColor,
                  boxShadow: [BoxShadow(color:
                  Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200]!,
                      spreadRadius: 1, blurRadius: 5)]),
              child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
            ),
          ),
        ),

        Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return profile.addressList != null
                ? profile.addressList.length != 0
                ?  SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: profile.addressList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Provider.of<ProfileProvider>(context, listen: false).setAddressIndex(index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.getIconBg(context),
                        border:
                        // index == Provider.of<OrderProvider>(context).addressIndex
                        //     ?
                        Border.all(width: 2, color: Theme.of(context).primaryColor)
                            // : null,
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          profile.addressList[index].addressType == 'Home' ? Images.home_image
                              : profile.addressList[index].addressType == 'Ofice' ? Images.bag : Images.more_image,
                          color: ColorResources.getSellerTxt(context), height: 30, width: 30,
                        ),
                        title: Text(profile.addressList[index].address!, style: cairoRegular),
                      ),
                    ),
                  );
                },
              ),
            )
                : Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
              child: Text('No address available'),
            )
                : Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
          },
        ),

        CustomButton(buttonText: getTranslated('add_new_address', context)!, onTap: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddAddressBottomSheet(),
          );
        }),
      ]),
    );
  }
}