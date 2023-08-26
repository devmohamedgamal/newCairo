//
// import 'dart:developer';
//
// import 'package:flutter/foundation.dart';
// import 'package:lemirageelevators/data/model/body/payment_order_model.dart';
// import 'package:lemirageelevators/data/model/response/response_model.dart';
// import 'package:lemirageelevators/data/repository/payment_repo.dart';
//
// class PaymentProvider extends ChangeNotifier {
//   final PaymentRepo paymentRepo;
//
//   PaymentProvider({required this.paymentRepo});
//
//   bool _loading = false;
//   String _authToken = '';
//   int? _paymentOrderId;
//   int? _integrationId = 4111870; // kiosk
//   String _paymentToken = '';
//
//   bool get loading => _loading;
//
//   void setIntegrationId(int integrationId){
//     _integrationId = integrationId;
//   }
//
//   Future<ResponseModel> initPayment({
//     required PaymentOrderModel orderModel,
//     required int integrationId,
//   }) async {
//     // Set integration id
//     setIntegrationId(integrationId);
//     // 1st
//     debugPrint('-------------');
//     var result = await getAuthRequest();
//     if(!result.isSuccess) return result;
//     // 2nd
//     debugPrint('-------------');
//     result = await registerPaymentOrder(orderModel);
//     if(!result.isSuccess) return result;
//     // 3rd
//     debugPrint('-------------');
//     result = await verifyPayment(orderModel);
//     return result;
//   }
//
//   // 1st step
//   Future<ResponseModel> getAuthRequest() async {
//     _loading = true;
//     notifyListeners();
//
//     final apiResponse = await paymentRepo.getAuthRequest();
//
//     late ResponseModel responseModel;
//     if(apiResponse.isSuccess(201)){
//       responseModel = ResponseModel.withSuccess();
//       _authToken = apiResponse.response!.data['token'];
//     } else {
//       responseModel = ResponseModel.withError(apiResponse.error.toString());
//       _loading = false;
//       notifyListeners();
//     }
//
//     return responseModel;
//   }
//
//   // 2nd step
//   Future<ResponseModel> registerPaymentOrder(PaymentOrderModel orderModel) async {
//     final apiResponse = await paymentRepo.registerPaymentOrder(
//       orderModel: orderModel,
//       authToken: _authToken,
//     );
//
//     late ResponseModel responseModel;
//     if(apiResponse.isSuccess(201)){
//       responseModel = ResponseModel.withSuccess();
//       _paymentOrderId = apiResponse.response!.data['id'];
//     } else {
//       responseModel = ResponseModel.withError(apiResponse.error.toString());
//       _loading = false;
//       notifyListeners();
//     }
//
//     return responseModel;
//   }
//
//   // 3rd step
//   Future<ResponseModel> verifyPayment(PaymentOrderModel orderModel) async {
//     final apiResponse = await paymentRepo.verifyPayment(
//       orderModel: orderModel,
//       authToken: _authToken,
//       orderId: '$_paymentOrderId',
//       integrationId: _integrationId!,
//     );
//
//     late ResponseModel responseModel;
//     if(apiResponse.isSuccess(201)){
//       responseModel = ResponseModel.withSuccess();
//       _paymentToken = apiResponse.response!.data['token'];
//     } else {
//       responseModel = ResponseModel.withError(apiResponse.error.toString());
//     }
//
//     _loading = false;
//     log('payment token: $_paymentToken');
//     notifyListeners();
//     return responseModel;
//   }
// }