class CouponModel {
  late final String? message;
  late final num discountPercentage;

  CouponModel({
    this.message,
    required this.discountPercentage,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    message = json['massage'];
    discountPercentage = json['discount_percentage'] ?? 0;
  }
}
