import 'package:newcairo/data/datasource/remote/dio/dio_client.dart';
import 'package:newcairo/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:newcairo/data/repository/auth_repo.dart';
import 'package:newcairo/data/repository/product_repo.dart';
import 'package:newcairo/data/repository/splash_repo.dart';
import 'package:newcairo/helper/network_info.dart';
import 'package:newcairo/provider/auth_provider.dart';
import 'package:newcairo/provider/localization_provider.dart';
import 'package:newcairo/provider/product_provider.dart';
import 'package:newcairo/provider/theme_provider.dart';
import 'package:newcairo/services/navigation_services.dart';
import 'package:newcairo/util/app_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'data/repository/home_repo.dart';
import 'provider/splash_provider.dart';

final sl = GetIt.instance;
GetIt locator = GetIt.I;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => NavigationServices());

  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => HomeRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));

  // External
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}
