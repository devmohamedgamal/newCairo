class PaymentModel {
  /// Do not use this var to show payment method name.
  ///
  /// Use this to get translation key to show translation of the payment method,
  /// like: (*.nameTrKey.tr(context)).
  late final String nameTrKey;
  late final String assetImagePath;

  /// This var is using when send the [PAYMENT METHOD] to api.
  late final String shortcutName;

  bool selected;

  PaymentModel({
    required this.nameTrKey,
    required this.assetImagePath,
    required this.shortcutName,
    this.selected = false,
  });
}
