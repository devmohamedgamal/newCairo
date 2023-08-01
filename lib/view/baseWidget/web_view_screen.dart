import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../localization/language_constrants.dart';
import '../../provider/cart_provider.dart';
import '../screen/dashboard/dashboard_screen.dart';
import 'custom_app_bar.dart';
import 'dialog/animated_custom_dialog.dart';
import 'my_dialog.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  WebViewScreen({required this.url,required this.title});
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}
class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    print("url 00==============>>>>>>> ${widget.url}");
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          CustomAppBar(title: widget.title),

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
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    print("url ========>>>> $url");
                    if (url.startsWith("https://www.gddeaf.net/true")) {
                      Provider.of<CartProvider>(context,listen: false).removeCart();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => DashBoardScreen()));

                        showAnimatedDialog(context,
                            MyDialog(
                              icon: Icons.check,
                              title: getTranslated('payment_process', context)!,
                              description: getTranslated('Successful_payment', context)!,
                              isFailed: false,
                            ),
                            dismissible: false,
                            isFlip: true);
                    }
                    else if (url.startsWith("https://www.gddeaf.net/false")) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => DashBoardScreen()));
                      showAnimatedDialog(
                          context,
                          MyDialog(
                        icon: Icons.clear,
                        title: getTranslated('payment_process', context)!,
                        description: getTranslated('Failed_payment', context)!,
                        isFailed: true,
                      ),
                          dismissible: false,
                          isFlip: true);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}