// ignore_for_file: prefer_final_fields, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_print, curly_braces_in_flow_control_structures
import 'dart:async';
import 'dart:developer';
import 'package:lemirageelevators/localization/language_constrants.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/util/images.dart';
import 'package:lemirageelevators/util/responsive.dart';
import 'package:lemirageelevators/view/screen/auth/auth_screen.dart';
import 'package:lemirageelevators/view/screen/home/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/splash_provider.dart';
import '../../baseWidget/no_internet_screen.dart';
import '../../baseWidget/web_view_screen.dart';

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
    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
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
          : NoInternetOrDataScreen(isNoInternet: true, child: SplashScreen()),
    );
  }

  void _route() {
        Provider.of<SplashProvider>(context, listen: false)
            .initSharedPrefData();
        Timer(Duration(seconds: 1), () async {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            await Provider.of<AuthProvider>(context, listen: false).getUser();
            await Provider.of<AuthProvider>(context, listen: false).getToken();
            var token = Provider.of<AuthProvider>(context, listen: false).token;
            log(token ?? 'null');
            var response =
                await Provider.of<AuthProvider>(context, listen: false).about();
            if (response['fetched_about_data']['landing_page'] == "5") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => WebViewScreen(
                        url:
                            'https://www.elbascet.com/newcairo/Website/home/$token',
                      )));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomeView()));
            }
          } else {
            if (Provider.of<SplashProvider>(context, listen: false)
                .showIntro()!) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => AuthScreen()));
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                  (route) => false);
            }
          }
        });
    }
}
