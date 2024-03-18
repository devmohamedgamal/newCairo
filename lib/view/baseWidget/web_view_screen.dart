import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/view/screen/home/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../localization/language_constrants.dart';
import '../screen/auth/auth_screen.dart';
import 'dialog/animated_custom_dialog.dart';
import 'my_dialog.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({Key? key, required this.url}) : super(key: key);
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    log('open webView url: "${widget.url}"');
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.url,
                    gestureNavigationEnabled: true,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    navigationDelegate: (navigation) {
                      if (navigation.url.contains('clients_logout')) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => AuthScreen()),
                            (route) => false);
                      }
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                      print("url ========>>>> $url");
                      if (url.startsWith("https://www.gddeaf.net/true")) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()));

                        showAnimatedDialog(
                            context,
                            MyDialog(
                              icon: Icons.check,
                              title: getTranslated('payment_process', context),
                              description:
                                  getTranslated('Successful_payment', context),
                              isFailed: false,
                            ),
                            dismissible: false,
                            isFlip: true);
                      } else if (url
                          .startsWith("https://www.gddeaf.net/false")) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()));
                        showAnimatedDialog(
                            context,
                            MyDialog(
                              icon: Icons.clear,
                              title: getTranslated('payment_process', context),
                              description:
                                  getTranslated('Failed_payment', context),
                              isFailed: true,
                            ),
                            dismissible: false,
                            isFlip: true);
                      } else if (url.contains('/clients_logout')) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthScreen()));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
