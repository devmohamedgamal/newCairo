// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/view/screen/address/widget/add_address_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/not_loggedin_widget.dart';
import '../../baseWidget/show_custom_modal_dialog.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (!isGuestMode) {
      Provider.of<ProfileProvider>(context, listen: false)
          .initAddressTypeList(context);
      Provider.of<ProfileProvider>(context, listen: false).getAddress();
    }
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('ADDRESS_LIST', context)!),
          isGuestMode
              ? Expanded(child: NotLoggedInWidget())
              : Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return profileProvider.addressList.length > 0
                            ? Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    profileProvider.initAddressTypeList(context);
                                    profileProvider.getAddress();
                                  },
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount:
                                        profileProvider.addressList.length,
                                    itemBuilder: (context, index) => Card(
                                      child: ListTile(
                                        title: Text(getTranslated("address", context)! +
                                            ' :  ${profileProvider.addressList[index].address}'),
                                        subtitle: Text(getTranslated("City", context)! +
                                            ' : ${profileProvider.addressList[index].city ?? ""}'),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete_forever,
                                              color: Colors.red),
                                          onPressed: () {
                                            showCustomModalDialog(
                                              context,
                                              title: getTranslated('REMOVE_ADDRESS', context)!,
                                              content: profileProvider.addressList[index].address!,
                                              cancelButtonText: getTranslated('CANCEL', context)!,
                                              submitButtonText: getTranslated('REMOVE', context)!,
                                              submitOnPressed: () {
                                                profileProvider.removeAddress(index);
                                                Navigator.of(context).pop();
                                              },
                                              cancelOnPressed: () =>
                                                  Navigator.of(context).pop(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Images.addresses, width: 150, height: 150),

                                        Text(getTranslated('no_addresses', context)!, style: cairoBold.copyWith(
                                          fontSize: 18,
                                          color: Theme.of(context).textTheme.bodyText1!.color,
                                        )),

                                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                        Text(getTranslated('click_add_address', context)!,
                                          textAlign: TextAlign.center,
                                          style: cairoRegular,
                                        ),
                                        SizedBox(height: 40),
                                      ],
                                    ),
                                  ),
                                ));
                  },
                ),
        ],
      ),
      floatingActionButton: isGuestMode
          ? null
          : FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => AddAddressBottomSheet(),
              ),
              child: Icon(Icons.add, color: Theme.of(context).highlightColor),
              backgroundColor: ColorResources.getPrimary(context),
            ),
    );
  }
}