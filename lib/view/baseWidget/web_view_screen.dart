import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import '../screen/auth/auth_screen.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({Key? key, required this.url}) : super(key: key);
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    log('open webView url: "${widget.url}"');
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

void addFileSelectionListener() async {
    if (Platform.isAndroid) {
      // final androidController = controllerGlobal as AndroidWebViewController;
      // await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }
//   Future<List<String>> _androidFilePicker(final FileSelectorParams params) async {
//   final result = await FilePicker.platform.pickFiles();

//   if (result != null && result.files.single.path != null) {
//     final file = File(result.files.single.path!);
//     return [file.uri.toString()];
//   }
//   return [];
// }
  Future<bool> goBack(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Do you want to exit'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.message),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => goBack(context),
      child: Scaffold(
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
                        _controller.future
                            .then((value) => controllerGlobal = value);
                      },
                      javascriptChannels: <JavascriptChannel>[
                        _toasterJavascriptChannel(context),
                      ].toSet(),
                      navigationDelegate: (navigation) {
                        if (navigation.url.contains('clients_logout')) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => AuthScreen()),
                              (route) => false);
                        }
                        return NavigationDecision.navigate;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
