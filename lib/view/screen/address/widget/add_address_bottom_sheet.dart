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
  // final FocusNode _cityFocus = FocusNode();
  // final FocusNode _zipCodeFocus = FocusNode();
  final TextEditingController _addressController = TextEditingController();
  // final TextEditingController _cityNameController = TextEditingController();
  // final TextEditingController _zipCodeController = TextEditingController();
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
                CustomTextField(
                  hintText: getTranslated('ENTER_YOUR_ADDRESS', context),
                  controller: _addressController,
                  textInputType: TextInputType.streetAddress,
                  focusNode: _buttonAddressFocus,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 30),
                Provider.of<ProfileProvider>(context).addAddressErrorText != null
                    ? Text(Provider.of<ProfileProvider>(context).addAddressErrorText!,
                           style: cairoRegular.copyWith(color: ColorResources.RED))
                    : SizedBox.shrink(),

                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, _) {
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
    if(_addressController.text.isEmpty) {
      profileProvider.setAddAddressErrorText(getTranslated('ADDRESS_FIELD_MUST_BE_REQUIRED', context),true);
    } else {
      profileProvider.setAddAddressErrorText(null,true);
      AddressModel addressModel = AddressModel();
      addressModel.addressType = profileProvider.addressType;
      addressModel.address = _addressController.text;
      addressModel.phone = '0';

      profileProvider.addAddress(context,addressModel,route);
    }
  }

  route(String message) {
    Navigator.of(context).pop();
    showCustomSnackBar(message,context,isError: false);
  }
}