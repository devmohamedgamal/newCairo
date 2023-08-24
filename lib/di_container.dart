import 'package:lemirageelevators/data/datasource/remote/dio/dio_client.dart';
import 'package:lemirageelevators/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:lemirageelevators/data/repository/auth_repo.dart';
import 'package:lemirageelevators/data/repository/gallery_repo.dart';
import 'package:lemirageelevators/data/repository/home_repo.dart';
import 'package:lemirageelevators/data/repository/notification_repo.dart';
import 'package:lemirageelevators/data/repository/onboarding_repo.dart';
import 'package:lemirageelevators/data/repository/order_repo.dart';
import 'package:lemirageelevators/data/repository/payment_repo.dart';
import 'package:lemirageelevators/data/repository/product_repo.dart';
import 'package:lemirageelevators/data/repository/search_repo.dart';
import 'package:lemirageelevators/data/repository/splash_repo.dart';
import 'package:lemirageelevators/data/repository/wish_repo.dart';
import 'package:lemirageelevators/helper/network_info.dart';
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
import 'package:lemirageelevators/provider/payment_provider.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/provider/profile_provider.dart';
import 'package:lemirageelevators/provider/search_provider.dart';
import 'package:lemirageelevators/provider/splash_provider.dart';
import 'package:lemirageelevators/provider/theme_provider.dart';
import 'package:lemirageelevators/provider/wishlist_provider.dart';
import 'package:lemirageelevators/services/navigation_services.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'data/repository/cart_repo.dart';
import 'data/repository/profile_repo.dart';

final sl = GetIt.instance;
GetIt locator = GetIt.I;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => NavigationServices());

  const paymentDioInstanceName = "payment_dio";

  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL,sl(), loggingInterceptor: sl(),sharedPreferences: sl()));
  sl.registerLazySingleton(
    () => DioClient(AppConstants.PAYMOB_BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()),
    instanceName: paymentDioInstanceName,
  );

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => OnBoardingRepo(dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => HomeRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => WishRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CartRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => OrderRepo(dioClient: sl()));
  sl.registerLazySingleton(() => GalleryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => PaymentRepo(dioClient: sl(instanceName: paymentDioInstanceName)));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => FacebookLoginProvider());
  sl.registerFactory(() => GoogleSignInProvider());
  sl.registerFactory(() => HomeProvider(homeRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => WishProvider(wishRepo: sl(),productRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  sl.registerFactory(() => GalleryProvider(galleryRepo: sl()));
  sl.registerFactory(() => PaymentProvider(paymentRepo: sl()));

  // External
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}