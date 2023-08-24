import 'package:lemirageelevators/data/model/body/payment_shipping_data_model.dart';

class PaymentOrderModel {
  late final bool deliveryNeeded;
  late final int amountCents;
  late final String currency;
  late final PaymentShippingDataModel paymentShippingDataModel;

  PaymentOrderModel({
    required this.amountCents,
    this.deliveryNeeded = false,
    this.currency = 'EGP',
    required this.paymentShippingDataModel,
  });

  Map toJson({
    required String authToken,
}){
    return {
      'auth_token': authToken,
      'delivery_needed': '$deliveryNeeded',
      'currency': currency,
      'amount_cents': '$amountCents',
      'shipping_data': paymentShippingDataModel!.toJson(),
    };
  }

  Map verifyPaymentToJson({
    required String authToken,
    required int integrationId,
    required String orderId,
  }){
    return {
      'auth_token': authToken,
      'delivery_needed': '$deliveryNeeded',
      'currency': currency,
      'amount_cents': '$amountCents',
      'billing_data': paymentShippingDataModel!.toJson(),
      'integration_id': integrationId,
      'order_id': orderId,
    };
  }
}
