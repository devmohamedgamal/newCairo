import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/baseWidget/dialog/delete_account_confirmation_dialog.dart';
import 'package:lemirageelevators/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:lemirageelevators/view/screen/more/widget/app_info_dialog.dart';
import 'package:lemirageelevators/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../provider/wishlist_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../baseWidget/dialog/animated_custom_dialog.dart';
import '../../baseWidget/dialog/guest_dialog.dart';
import '../../baseWidget/dialog/sign_out_confirmation_dialog.dart';
import '../about/about_screen.dart';
import '../address/address_screen.dart';
import '../cart/cart_screen.dart';
import '../category/all_category_screen.dart';
import '../gallery/albums/albums_screen.dart';
import '../gallery/videos/videos_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';
import '../setting/settings_screen.dart';
import '../wish/wish_screen.dart';

class MoreScreen extends StatefulWidget {
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}
class _MoreScreenState extends State<MoreScreen> {
  bool? isGuestMode;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  checkAuth() async {
    isGuestMode = !Provider.of<AuthProvider>(context,listen: false).isLoggedIn();
    if(!isGuestMode!) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context,
          Provider.of<AuthProvider>(context, listen: false).user!.userId!);
      Provider.of<WishProvider>(context,listen: false).initWishList(context,
          Provider.of<AuthProvider>(context,listen: false).user!.userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            child: Image.asset(
              Images.toolbar_background,
              fit: BoxFit.fill,
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: Provider.of<ThemeProvider>(context).darkTheme
                  ? Colors.black : null,
            ),
          ),
        ),

        // AppBar
        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Consumer<AuthProvider>(
            builder: (context, profile, child) {
              return Row(children: [
                Image.asset(Images.logo, height: 35, color: ColorResources.WHITE),
                Expanded(child: SizedBox.shrink()),
                InkWell(
                  onTap: () {
                    if(isGuestMode!) {
                      showAnimatedDialog(context, GuestDialog(), isFlip: true);
                    }
                    else {
                      if(Provider.of<AuthProvider>(context,listen: false).user != null) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10,10,10,0),
                    child: Row(children: [
                      Text(!isGuestMode! && profile.user != null
                            ? '${profile.user!.fullName}'
                            : getTranslated("GUEST", context),
                          style: cairoRegular.copyWith(color: ColorResources.WHITE)),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      isGuestMode!
                          ? CircleAvatar(child: Icon(Icons.person, size: 35))
                          : profile.user == null
                          ? CircleAvatar(child: Icon(Icons.person, size: 35))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.logo, width: 35, height: 35, fit: BoxFit.fill,
                          image: '${AppConstants.BASE_URL_IMAGE}${profile.user!.avatar}',
                          imageErrorBuilder: (c, o, s) => CircleAvatar(child: Icon(Icons.person, size: 35)),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]);
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getIconBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // Top Row Items
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SquareButton(image: Images.shopping_image,
                          title: getTranslated('orders', context),
                      navigateTo: OrderScreen(),
                      count: 1,hasCount: false,),

                        SquareButton(image: Images.cart_image,
                          title: getTranslated('CART', context),
                      navigateTo: CartScreen(),
                      count: Provider.of<CartProvider>(context).cartList.length, hasCount: true,),
                        SquareButton(image: Images.offers,
                      title: getTranslated('offers', context),
                      navigateTo: FeaturedDealScreen(),
                      count: 0,hasCount: false,),
                        SquareButton(image: Images.wishlist,
                          title: getTranslated('wishlist', context),
                      navigateTo: WishScreen(),
                      count: 0, hasCount: false,),
                      ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  TitleButton(image: Images.more_filled_image,
                      title: getTranslated('all_category', context),
                      navigateTo: AllCategoryScreen()
                  ),
                  TitleButton(image: Images.fast_delivery,
                    title: getTranslated('address', context),
                      navigateTo: AddressScreen()
                  ),
                  TitleButton(image: Images.image_gallery,
                    title: getTranslated('Photo_album', context),
                      navigateTo: AlbumsScreen()
                  ),
                  TitleButton(image: Images.video_player,
                    title: getTranslated('Video_Gallery', context),
                      navigateTo: VideosScreen()
                  ),
                  TitleButton(image: Images.notification_filled, title: getTranslated('notification', context),
                      navigateTo: NotificationScreen()
                  ),
                  TitleButton(
                    image: Images.settings,
                    title: getTranslated('settings', context),
                      navigateTo: SettingsScreen()
                  ),
                  TitleButton(image: Images.about_us, title: getTranslated('about_us', context),
                      navigateTo: AboutScreen()
                  ),

                  ListTile(
                    leading: Image.asset(Images.logo, width: 25, height: 25,
                        fit: BoxFit.fill, color: ColorResources.getPrimary(context)),
                    title: Text(getTranslated('app_info', context),
                        style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                    onTap: () => showAnimatedDialog(context, AppInfoDialog(), isFlip: true),
                  ),

                  // Account deletion request
                  if(!isGuestMode! && Platform.isIOS)
                      ListTile(
                    leading: Icon(Icons.delete_outline, color: ColorResources.getPrimary(context), size: 25),
                    title: Text(getTranslated('account_deletion_request', context),
                        style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                    onTap: () => showAnimatedDialog(
                        context, DeleteAccountConfirmationDialog(), isFlip: true),
                  ),

                  isGuestMode!
                      ? SizedBox()
                      : ListTile(
                    leading: Icon(Icons.exit_to_app, color: ColorResources.getPrimary(context), size: 25),
                    title: Text(getTranslated('sign_out', context),
                        style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                    onTap: () => showAnimatedDialog(
                        context, SignOutConfirmationDialog(), isFlip: true),
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;
  SquareButton({required this.image,required this.title,
    required this.navigateTo,
    required this.count, required this.hasCount});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.getPrimary(context),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(image, color: Theme.of(context).highlightColor),
              hasCount?
              Positioned(top: -4, right: -4,
                child: Consumer<CartProvider>(builder: (context, cart, child) {
                  return CircleAvatar(radius: 8, backgroundColor: ColorResources.RED,
                    child: Text(count.toString(),
                        textAlign: TextAlign.center,
                        style: cairoSemiBold.copyWith(color: ColorResources.WHITE,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        )),
                  );
                }),
              ):SizedBox(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: cairoRegular),
        ),
      ]),
    );
  }
}
class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton({required this.image,required this.title,
    required this.navigateTo
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image, width: 25, height: 25, fit: BoxFit.fill, color: ColorResources.getPrimary(context)),
      title: Text(title, style: cairoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => Navigator.push(
        context,
        /*PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
              return ScaleTransition(scale: animation, child: child, alignment: Alignment.center);
            },
          ),*/
        MaterialPageRoute(builder: (_) => navigateTo),
      ),
      /*onTap: () => Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: Duration(milliseconds: 500),
      )),*/
    );
  }
}