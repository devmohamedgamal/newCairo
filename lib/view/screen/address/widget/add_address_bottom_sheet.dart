import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/body/address_model.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../baseWidget/button/custom_button.dart';
import '../../../baseWidget/show_custom_snakbar.dart';
import '../../../baseWidget/textfield/custom_textfield.dart';

class AddAddressBottomSheet extends StatefulWidget {
  @override
  _AddAddressBottomSheetState createState() => _AddAddressBottomSheetState();
}
class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final FocusNode _buttonAddressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).setAddAddressErrorText(null,false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
                  return Container(
                    padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
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
                    child: DropdownButtonFormField<String>(
                      value: profileProvider.addressType,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(border: InputBorder.none),
                      iconSize: 24,
                      elevation: 16,
                      style: cairoRegular,
                      onChanged: profileProvider.updateAddressType,
                      items: profileProvider.addressTypeList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: cairoRegular.copyWith(
                              color: Theme.of(context).textTheme.bodyText1!.color)),
                        );
                      }).toList(),
                    ),
                  );
                }),
                Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: getTranslated('ENTER_YOUR_ADDRESS', context),
                  controller: _addressController,
                  textInputType: TextInputType.streetAddress,
                  focusNode: _buttonAddressFocus,
                  nextNode: _cityFocus,
                  textInputAction: TextInputAction.next,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: getTranslated('ENTER_YOUR_CITY', context),
                  controller: _cityNameController,
                  textInputType: TextInputType.streetAddress,
                  focusNode: _cityFocus,
                  nextNode: _zipCodeFocus,
                  textInputAction: TextInputAction.next,
                ),
                Divider(thickness: 0.7, color: ColorResources.GREY),
                CustomTextField(
                  hintText: getTranslated('ENTER_YOUR_ZIP_CODE', context),
                  isPhoneNumber: true,
                  controller: _zipCodeController,
                  textInputType: TextInputType.number,
                  focusNode: _zipCodeFocus,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 30),
                Provider.of<ProfileProvider>(context).addAddressErrorText != null
                    ? Text(Provider.of<ProfileProvider>(context).addAddressErrorText!,
                    style: cairoRegular.copyWith(color: ColorResources.RED))
                    : SizedBox.shrink(),
                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return profileProvider.isLoading
                        ? CircularProgressIndicator(key: Key(''),
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))
                        : CustomButton(
                      buttonText: getTranslated('UPDATE_ADDRESS', context)!,
                      onTap: () {
                        _addAddress(Provider.of<ProfileProvider>(context,listen: false));
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addAddress(ProfileProvider profileProvider) {
    if(profileProvider.addressType == profileProvider.addressTypeList[0]) {
      profileProvider.setAddAddressErrorText(getTranslated('SELECT_ADDRESS_TYPE', context),true);
    }
    else if(_addressController.text.isEmpty) {
      profileProvider.setAddAddressErrorText(getTranslated('ADDRESS_FIELD_MUST_BE_REQUIRED', context),true);
    }
    else if(_cityNameController.text.isEmpty) {
      profileProvider.setAddAddressErrorText(getTranslated('CITY_FIELD_MUST_BE_REQUIRED', context),true);
    }
    else if(_zipCodeController.text.isEmpty) {
      profileProvider.setAddAddressErrorText(getTranslated('ZIPCODE_FIELD_MUST_BE_REQUIRED', context),true);
    }
    else {
      profileProvider.setAddAddressErrorText(null,true);
      AddressModel addressModel = AddressModel();
      addressModel.addressType = profileProvider.addressType;
      addressModel.city = _cityNameController.text;
      addressModel.address = _addressController.text;
      addressModel.zip = _zipCodeController.text;
      addressModel.phone = '0';

      profileProvider.addAddress(context,addressModel,route);
    }
  }

  route(String message) {
    Navigator.of(context).pop();
    showCustomSnackBar(message,context,isError: false);
  }
}