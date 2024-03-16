import 'package:flutter/cupertino.dart';
import 'package:lemirageelevators/data/model/response/payment_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/error_response.dart';
import '../data/model/response/cart_model.dart';
import '../data/model/response/order_model.dart';
import '../data/model/response/status_model.dart';
import '../data/repository/order_repo.dart';
import '../helper/api_checker.dart';
import '../util/app_constants.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepo orderRepo;
  OrderProvider({required this.orderRepo});

  List<Order>? _pendingList;
  List<Order>? _deliveredList;
  List<Order>? _canceledList;
  bool _isLoading = false;
  int _paymentMethodIndex = 1;
  int _orderTypeIndex = 0;
  Order? _trackingModel;
  PaymentModel? _selectedPaymentModel;

  Order? get trackingModel => _trackingModel;
  int get orderTypeIndex => _orderTypeIndex;
  List<Order>? get pendingList =>
      _pendingList != null ? _pendingList!.reversed.toList() : _pendingList;
  List<Order>? get deliveredList => _deliveredList != null
      ? _deliveredList!.reversed.toList()
      : _deliveredList;
  List<Order>? get canceledList =>
      _canceledList != null ? _canceledList!.reversed.toList() : _canceledList;
  bool get isLoading => _isLoading;
  int get paymentMethodIndex => _paymentMethodIndex;
  PaymentModel? get selectedPaymentModel => _selectedPaymentModel;
  bool get isPaymentMethodSelected => _selectedPaymentModel != null;

  Future<void> initOrderList(BuildContext context, String clientId) async {
    ApiResponse apiResponse = await orderRepo.getOrderList(clientId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _pendingList = [];
      _deliveredList = [];
      _canceledList = [];
      OrderModel orderModel;
      orderModel = OrderModel.fromJson(apiResponse.response!.data);
      orderModel.fetchedOrders!.forEach((order) {
        if (order.status == AppConstants.PENDING ||
            order.status == AppConstants.TO_DELIVER) {
          _pendingList!.add(order);
        } else if (order.status == AppConstants.DELIVERED) {
          _deliveredList!.add(order);
        } else if (order.status == AppConstants.CANCELLED) {
          _canceledList!.add(order);
        }
      });
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void selectPaymentMethod(PaymentModel paymentModel) {
    _selectedPaymentModel = paymentModel;
    notifyListeners();
  }

  Future<void> placeOrder(
    CartModel cartModel,
    Function callback, {
    dynamic PaymentMethod = 'card_pay_mob',
  }) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse =
        await orderRepo.placeOrder(cartModel, PaymentMethod);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      try {
        StatusModel statusModel;
        statusModel = StatusModel.fromJson(apiResponse.response!.data);
        callback(statusModel.status, statusModel.refId ?? statusModel.url,
            statusModel.massage.toString());
      } catch (_) {
        callback(true, '', 'The order placed successfully');
      }

      _selectedPaymentModel = null;
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse? errorResponse = apiResponse.error;
        print(errorResponse?.errors?.message);
        errorMessage =
            errorResponse?.errors?.message ?? 'Unknown Error occurred';
      }
      callback(false, null, errorMessage);
    }
    notifyListeners();
  }

  Future<void> cancelOrder(String orderId, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo.cancelOrder(orderId);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      StatusModel statusModel;
      statusModel = StatusModel.fromJson(apiResponse.response!.data);
      callback(statusModel.status, statusModel.massage.toString());
    } else {
      callback(false, apiResponse.error.toString());
    }
    notifyListeners();
  }

  void setIndex(int index) {
    _orderTypeIndex = index;
    notifyListeners();
  }

  void stopLoader() {
    _isLoading = false;
    notifyListeners();
  }

  void setPaymentMethod(int index) {
    _paymentMethodIndex = index;
    notifyListeners();
  }
}
