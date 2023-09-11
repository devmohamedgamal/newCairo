// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';

class PriceConverter {
  static String calculateTotal(BuildContext context, String price, int quantity) {
    double total = 0.0;
    total = double.parse(price) * quantity;
    return total.toString();
  }

  static double convertWithDiscount(BuildContext context, double price, double discount, String discountType) {
    if (discountType == 'amount' || discountType == 'flat') {
      price = price - discount;
    } else if (discountType == 'percent' || discountType == 'percentage') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount' || type == 'flat') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent' || type == 'percentage') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

// static String percentageCalculation(BuildContext context, double price, double discount, String discountType) {
//   return '${(discountType == 'percent' || discountType == 'percentage') ? '$discount %'
//       : convertPrice(context, discount)} OFF';
// }
}
