import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lemirageelevators/di_container.dart';
import 'package:lemirageelevators/helper/custom_delegate.dart';
import 'package:lemirageelevators/localization/app_localization.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/provider/cart_provider.dart';
import 'package:lemirageelevators/provider/facebook_login_provider.dart';
import 'package:lemirageelevators/provider/gallery_provider.dart';
import 'package:lemirageelevators/provider/google_sign_in_provider.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/provider/localization_provider.dart';
import 'package:lemirageelevators/provider/notification_provider.dart';
import 'package:lemirageelevators/provider/onboarding_provider.dart';
import 'package:lemirageelevators/provider/order_provider.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/provider/profile_provider.dart';
import 'package:lemirageelevators/provider/search_provider.dart';
import 'package:lemirageelevators/provider/splash_provider.dart';
import 'package:lemirageelevators/provider/theme_provider.dart';
import 'package:lemirageelevators/provider/wishlist_provider.dart';
import 'package:lemirageelevators/services/navigation_services.dart';
import 'package:lemirageelevators/theme/dark_theme.dart';
import 'package:lemirageelevators/theme/light_theme.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/view/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import './util/router.dart' as router;
import 'notification/my_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await di.init();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  int? _orderID;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    _orderID = (notificationAppLaunchDetails!.payload != null && notificationAppLaunchDetails.payload!.isNotEmpty)
        ? int.parse(notificationAppLaunchDetails.payload!)
        : null;
  }
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FacebookLoginProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<GoogleSignInProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<GalleryProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    for (var language in AppConstants.languages!) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    }
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
      supportedLocales: _locals,
      home: SplashScreen(),
    );
  }
}
