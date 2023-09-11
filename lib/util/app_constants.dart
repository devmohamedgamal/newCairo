// ignore_for_file: constant_identifier_names
import 'package:lemirageelevators/data/model/response/payment_model.dart';
import 'package:lemirageelevators/util/images.dart';

import '../data/model/response/language_model.dart';

class AppConstants {
  static const String APP_NAME = 'GDDeaf';  //NAME APP

  // ALL URLs
  // static const String BASE_URL = 'https://www.gddeaf.net/App_api/';
  static const String _DOMAIN = 'http://213.136.84.116/~souq/mr_test';
  static const String BASE_URL = '$_DOMAIN/App_api/';
  static const String BASE_URL_IMAGE = "$_DOMAIN/uploads/";

  static const String GET_PRODUCT_URL = 'get_product';
  static const String CATEGORY_PRODUCT_URI = 'category_producte/';
  static const String HOME_URI = 'homepage';
  static const String PRODUCT_DETAILS_URL = 'product_details';
  static const String SETTINGS_URL = 'settings';
  static const String LOGIN_URI = 'login';
  static const String REGISTRATION_URI = 'register';
  static const String LOGIN_SOCIAL_URI = 'login_social';
  static const String FORGET_PASSWORD_URI = 'forgot_password';
  static const String ALL_ALBUMS_URL = 'pics';
  static const String ALBUM_URL = 'album?albom_id=';
  static const String CLIENT_PROFILE_URL = 'client_profile?client_id=';
  static const String VIDEO_URL = 'video';
  static const String SHIPPING_URL = 'shipping';
  static const String ORDER_PLACE_URI = 'placeorder';
  static const String ORDER_URI = 'last_order?client_id=';
  static const String GET_WISH_URL = 'get_wish?client_id=';
  static const String ADD_WISH_URL = 'add_wish?customer_id=';
  static const String NOTIFICATION_URI = 'get_all_not?client_id=';
  static const String RATING_URL = 'rating';
  static const String CONTACT_URL = 'contact';
  static const String ABOUT_URL = 'about';
  static const String SEARCH_URI = 'search?search=';
  static const String UPDATE_PROFILE_URI = 'update_profile';
  static const String CANCEL_ORDER_URI = 'cancel_order?id=';
  static const String GET_SUGGESTED_PRODUCTS_URI = 'get_suggest_product';
  static const String ADD_SUGGESTED_PRODUCTS_URI = 'add_suggest_product';
  static const String CHECK_COUPON_URI = 'check_copon';

  // Payment gateway
  static const String PAYMOB_BASE_URL = 'https://accept.paymob.com/api';
  static const String PAYMOB_API_KEY = '';


  static const String PAYMOB_AUTH_REQUEST_URI = '/auth/tokens'; // 1st step
  static const String PAYMOB_MAKE_ORDER_URI = '/ecommerce/orders'; // 2nd step
  static const String PAYMOB_GET_PAYMENT_TOKEN_URI = '/acceptance/payment_keys'; // 3rd step

  // sharePreference
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String REMEMBER = 'remember';
  static const String USER = 'user';
  static const String START = 'start';
  static const String INTRO = 'intro';
  static const String SAVE_CUSTOMER = 'SAVE_CUSTOMER';
  static const String THEME = 'theme';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String CART_LIST = 'cart_list';
  static const String ADDRESSES_LIST = 'addresses_list';

  // order status
  static const String PENDING = 'pending';
  static const String TO_DELIVER = 'to_deliver';
  static const String DELIVERED = 'order_delivered';
  static const String CANCELLED = 'cancel';

  // All Payment methods
  static List<PaymentModel> paymentMethods = [
    PaymentModel(nameTrKey: 'Credit Card', assetImagePath: Images.paymobCreditCard, shortcutName: 'card_pay_mob'),
    PaymentModel(nameTrKey: 'Paymob Wallet', assetImagePath: Images.paymobWallet, shortcutName: 'wallet_paymob'),
    PaymentModel(nameTrKey: 'Kiosk paymob', assetImagePath: Images.paymobKiosk, shortcutName: 'kiosk_paymob'),
    PaymentModel(nameTrKey: 'ValU', assetImagePath: Images.paymobValu, shortcutName: 'valU_paymob'),
  ];

  // ALL LANGUAGE
  static List<LanguageModel>? languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}