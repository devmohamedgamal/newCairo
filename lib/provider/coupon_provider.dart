import 'package:flutter/cupertino.dart';
import 'package:lemirageelevators/data/model/response/coupon_model.dart';
import 'package:lemirageelevators/data/repository/coupon_respo.dart';
import 'package:lemirageelevators/view/baseWidget/show_custom_snakbar.dart';

class CouponProvider extends ChangeNotifier {
  final CouponRepo couponRepo;

  CouponProvider({required this.couponRepo});

  String? _code;
  CouponModel? _coupon;
  bool _isLoading = false;

  CouponModel? get coupon => _coupon;

  double get discountPercentage => _coupon?.discountPercentage.toDouble() ?? 0;

  bool get isLoading => _isLoading;

  String get couponCode => _code ?? '';

  Future<void> checkCoupon(String code, BuildContext context) async {
    removeCouponData(false);
    _isLoading = true;
    notifyListeners();

    try {
      final apiResponse = await couponRepo.checkCoupon(code);
      if (apiResponse.isSuccess()) {
        _code = code;
        _coupon = CouponModel.fromJson(apiResponse.response!.data);
      } else {
        showCustomSnackBar('Invalid coupon', context, isError: true);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeCouponData(bool notify) {
    _coupon = null;
    _code = null;
    _isLoading = false;
    if (notify) {
      notifyListeners();
    }
  }
}
