// ignore_for_file: prefer_final_fields, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_print, curly_braces_in_flow_control_structures
import 'dart:async';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/provider/gallery_provider.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/images.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/view/screen/auth/auth_screen.dart';
import 'package:lemirageelevators/view/screen/home/home_screen.dart';
import 'package:lemirageelevators/view/screen/onboarding/onboarding_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../baseWidget/no_internet_screen.dart';
import '../dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected
                ? getTranslated('no_connection', context)
                : getTranslated('connected', context),
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _route();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Provider.of<SplashProvider>(context).hasConnection
          ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.splash_bg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: width(context) * 0.7,
            height: height(context) * 0.4,
            child: Image.asset(
              Images.logo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      )
          : NoInternetOrDataScreen(
          isNoInternet: true,
          child: SplashScreen()
      ),
    );
  }

  void _route() {
    Provider.of<SplashProvider>(context, listen: false).initAppInfo(context).then((bool isSuccess) {
      if(isSuccess) {
        Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
        Provider.of<HomeProvider>(context, listen: false).getHomeData(false,context);
        Provider.of<GalleryProvider>(context, listen: false).getVideosGallery(context);
        Provider.of<GalleryProvider>(context, listen: false).getAlbumsGallery(context);
        Provider.of<CartProvider>(context, listen: false).getCartData();
        Provider.of<CartProvider>(context, listen: false).initPaymentTypeList(context);
        Provider.of<CartProvider>(context, listen: false).getShippingPlaces(context);
        Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
        Timer(Duration(seconds: 1), () async {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            await Provider.of<AuthProvider>(context,listen: false).getUser();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomeView()));
          }
          else {
            if(Provider.of<SplashProvider>(context, listen: false).showIntro()!) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => OnBoardingScreen(
                    indicatorColor: ColorResources.GREY,
                    selectedIndicatorColor: Theme.of(context).primaryColor,
                  )));
            }
            else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
            }
          }
        });
      }
    });
  }
}