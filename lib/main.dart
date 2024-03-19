import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lemirageelevators/di_container.dart';
import 'package:lemirageelevators/helper/custom_delegate.dart';
import 'package:lemirageelevators/localization/app_localization.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/provider/localization_provider.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/provider/splash_provider.dart';
import 'package:lemirageelevators/provider/theme_provider.dart';
import 'package:lemirageelevators/services/navigation_services.dart';
import 'package:lemirageelevators/theme/dark_theme.dart';
import 'package:lemirageelevators/theme/light_theme.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import './util/router.dart' as router;
import 'notification/firebase_api.dart';
import 'notification/my_notification.dart';
import 'view/screen/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await di.init();
  await FirebaseApi().requestAndGetToken();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await Permission.camera.request();
  final token = await FirebaseMessaging.instance.getToken();
  debugPrint('token: $token');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Locale> locals = AppConstants.languages
        .map((e) => Locale(e.languageCode, e.countryCode))
        .toList();

    return MaterialApp(
      title: AppConstants.APP_NAME,
      navigatorKey: locator<NavigationServices>().navigatorKey,
      onGenerateRoute: router.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      supportedLocales: locals,
      home: SplashScreen(),
    );
  }
}
