// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:lemirageelevators/view/screen/wish/widget/wish_widget.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/wishlist_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../../../util/responsive.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/not_loggedin_widget.dart';
import '../../baseWidget/spacer.dart';

class WishScreen extends StatefulWidget {
  @override
  State<WishScreen> createState() => _WishScreenState();
}
class _WishScreenState extends State<WishScreen> {
  late bool isGuestMode;
  @override
  void initState() {
    isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (!isGuestMode) {
      Provider.of<WishProvider>(context, listen: false).initWishList(
        context,Provider.of<AuthProvider>(context,listen: false).user!.userId!
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('wishlist', context)!),

          Expanded(
            child: isGuestMode
                ? NotLoggedInWidget()
                : Consumer<WishProvider>(
                    builder: (context, wishProvider, child) {
                      return wishProvider.wishList.length > 0
                          ? RefreshIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                              onRefresh: () async {
                                await wishProvider.initWishList(context,
                                    Provider.of<AuthProvider>(context,listen: false).user!.userId!);
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: wishProvider.wishList.length,
                                itemBuilder: (context, index) => WishListWidget(
                                  wish: wishProvider.wishList[index],
                                  index: index,
                                ),
                              ),
                            )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Images.wish_image,
                              width: width(context) * 0.5,
                              height: height(context) * 0.1),
                          HSpacer(15),
                          Text(
                            getTranslated("no_products_wish", context)!,
                            style: cairoSemiBold,
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}