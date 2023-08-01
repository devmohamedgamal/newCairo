import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../baseWidget/dialog/animated_custom_dialog.dart';
import '../../../baseWidget/dialog/guest_dialog.dart';
import '../../../baseWidget/show_custom_snakbar.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final String? productId;
  FavouriteButton({this.backgroundColor = Colors.black,
    this.favColor = Colors.white, this.isSelected = false,this.productId});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    return Consumer<WishProvider>(
        builder: (context, wishProvider, child) => GestureDetector(
      onTap: () {
        if (isGuestMode) {
          showAnimatedDialog(context, GuestDialog(), isFlip: true);
        }
        else {
          wishProvider.isWish
              ? wishProvider.removeWishList(context,
              Provider.of<AuthProvider>(context,
                  listen: false).user!.userId!,productId!,
              callback: feedbackMessage)
              : wishProvider.addWishList(context,
              Provider.of<AuthProvider>(context,
                  listen: false).user!.userId!
              ,productId!,feedbackMessage);
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Image.asset(
            wishProvider.isWish ? Images.wish_image : Images.wishlist,
            color: favColor,
            height: 30,
            width: 30,
          ),
        ),
      ),
    ));
  }

  feedbackMessage(bool status,String message,BuildContext context) {
    showCustomSnackBar(message,context, isError: !status);
  }
}