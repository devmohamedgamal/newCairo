// ignore_for_file: curly_braces_in_flow_control_structures, prefer_is_empty
import 'package:lemirageelevators/data/model/response/base/error_response.dart';
import 'package:dio/dio.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "تم إلغاء الطلب إلى خادم API";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "يجب فحص حالة الانترنت واعادة المحاولة";
              break;
            case DioExceptionType.badCertificate:
            case DioExceptionType.connectionError:
            case DioExceptionType.unknown:
              errorDescription = "فشل الاتصال بخادم API";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription = "تلقي المهلة فيما يتعلق بخادم API";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.errors != null) {
                    if (errorResponse.errors!.name != null) {
                      errorDescription = errorResponse.errors!.name;
                    } else if (errorResponse.errors!.phone != null) {
                      errorDescription = errorResponse.errors!.phone;
                    } else if (errorResponse.errors!.customerGroup != null) {
                      errorDescription = errorResponse.errors!.customerGroup;
                    } else if (errorResponse.errors!.email != null) {
                      errorDescription = errorResponse.errors!.email;
                    } else if (errorResponse.errors!.address != null) {
                      errorDescription = errorResponse.errors!.address;
                    } else if (errorResponse.errors!.city != null) {
                      errorDescription = errorResponse.errors!.city;
                    } else if (errorResponse.errors!.title != null) {
                      errorDescription = errorResponse.errors!.title;
                    } else if (errorResponse.errors!.line1 != null) {
                      errorDescription = errorResponse.errors!.line1;
                    } else if (errorResponse.errors!.lat != null) {
                      errorDescription = errorResponse.errors!.lat;
                    } else if (errorResponse.errors!.lng != null) {
                      errorDescription = errorResponse.errors!.lng;
                    } else if (errorResponse.errors!.state != null) {
                      errorDescription = errorResponse.errors!.state;
                    } else if (errorResponse.errors!.country != null) {
                      errorDescription = errorResponse.errors!.country;
                    } else if (errorResponse.errors!.identity != null) {
                      errorDescription = errorResponse.errors!.identity;
                    } else if (errorResponse.errors!.password != null) {
                      errorDescription = errorResponse.errors!.password;
                    } else if (errorResponse.errors!.amountPaid != null) {
                      errorDescription = errorResponse.errors!.amountPaid;
                    } else if (errorResponse.errors!.customer != null) {
                      errorDescription = errorResponse.errors!.customer;
                    } else if (errorResponse.errors!.giftCardNo != null) {
                      errorDescription = "رقم بطاقة الهدايا غير صالحة";
                    } else if (errorResponse.errors!.sale != null) {
                      errorDescription = errorResponse.errors!.sale;
                    } else if (errorResponse.errors!.referenceNo != null) {
                      errorDescription = errorResponse.errors!.referenceNo;
                    } else if (errorResponse.errors!.paidBy != null) {
                      errorDescription = errorResponse.errors!.paidBy;
                    } else if (errorResponse.errors!.totalCash != null) {
                      errorDescription = errorResponse.errors!.totalCash;
                    } else if (errorResponse.errors!.totalCheques != null) {
                      errorDescription = errorResponse.errors!.totalCheques;
                    } else if (errorResponse.errors!.totalCcSlips != null) {
                      errorDescription = errorResponse.errors!.totalCcSlips;
                    } else if (errorResponse.errors!.cashInHand != null) {
                      errorDescription = errorResponse.errors!.cashInHand;
                    } else if (errorResponse.errors!.price != null) {
                      errorDescription = errorResponse.errors!.price;
                    } else {
                      errorDescription = errorResponse.errors!.error;
                    }
                  } else if (errorResponse.message != null) {
                    errorDescription = errorResponse.message;
                  } else {
                    if (errorResponse.error == 'Unauthorized') {
                      errorDescription =
                          "تم تسجيل دخول من جهاز اخر بنفس الحساب";
                    } else {
                      errorDescription = errorResponse.error;
                    }
                  }
                  break;
                case 401:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response!.data);
                  if (error.response!.statusMessage == 'Unauthorized') {
                    errorDescription = "تم تسجيل دخول من جهاز اخر بنفس الحساب";
                  } else {
                    errorDescription = errorResponse.error;
                  }
                  break;
                case 307:
                case 403:
                case 404:
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  ErrorResponse? errorResponse =
                      error.response!.data is Map<String, dynamic>
                          ? ErrorResponse.fromJson(error.response!.data)
                          : null;
                  if (errorResponse?.errors != null)
                    errorDescription = errorResponse;
                  else
                    errorDescription =
                        "Failed to load data - status code: ${error.response!.statusCode}";
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "إرسال المهلة مع الخادم";
              break;
          }
        } else {
          errorDescription = "حدث خطأ غير متوقع";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    }
    // else {
    //   errorDescription = "is not a subtype of exception";
    // }
    return errorDescription;
  }
}
