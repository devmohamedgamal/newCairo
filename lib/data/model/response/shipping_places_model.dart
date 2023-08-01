class ShippingPlacesModel {
  ShippingPlacesModel({
    this.shipping,
  });

  List<Places>? shipping;

  factory ShippingPlacesModel.fromJson(Map<String, dynamic> json) => ShippingPlacesModel(
    shipping: List<Places>.from(json["shipping"].map((x) => Places.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shipping": List<dynamic>.from(shipping!.map((x) => x.toJson())),
  };
}

class Places {
  String? id;
  String? price;
  String? office;
  String? arabic;
  String? english;

  Places({
    this.id,
    this.price,
    this.office,
    this.arabic,
    this.english,
  });

  factory Places.fromJson(Map<String, dynamic> json) => Places(
    id: json["id"],
    price: json["price"],
    office: json["office"],
    arabic: json["arabic"],
    english: json["english"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "office": office,
    "arabic": arabic,
    "english": english,
  };
}