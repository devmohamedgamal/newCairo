import 'package:lemirageelevators/data/model/response/home_model.dart';

class DetailsProductModel {
  Product? product;
  Map<String, List<FetchedProductSize>>? fetchedProductSize;
  Map<String, List<FetchedProductSize>>? fetchedProductSizeEN;
  List<String>? fetchedPhotoData;
  List<dynamic>? fetchedCommentsData;

  DetailsProductModel({
    this.product,
    this.fetchedProductSize,
    this.fetchedProductSizeEN,
    this.fetchedPhotoData,
    this.fetchedCommentsData,
  });

  factory DetailsProductModel.fromJson(Map<String, dynamic> json) => DetailsProductModel(
    product: Product.fromJson(json["product"]),
    fetchedProductSize: Map.from(json["fetched_product_size"]).map((k,
        v) => MapEntry<String, List<FetchedProductSize>>(k,
        List<FetchedProductSize>.from(v.map((x) => FetchedProductSize.fromJson(x))))),

    fetchedProductSizeEN: Map.from(json["fetched_product_sizeEN"]).map((k,
        v) => MapEntry<String, List<FetchedProductSize>>(k,
        List<FetchedProductSize>.from(v.map((x) => FetchedProductSize.fromJson(x))))),

    fetchedPhotoData: json["fetched_photo_data"] != null
        ? List<String>.from(json["fetched_photo_data"].map((x) => x)) : [],
    fetchedCommentsData: List<dynamic>.from(json["fetched_comments_data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product": product!.toJson(),
    "fetched_product_size": Map.from(fetchedProductSize!).map((k, v) => MapEntry<String, dynamic>(k,
        List<dynamic>.from(v.map((x) => x.toJson())))),
    "fetched_product_sizeEN": Map.from(fetchedProductSizeEN!).map((k, v) => MapEntry<String, dynamic>(k,
        List<dynamic>.from(v.map((x) => x.toJson())))),
    "fetched_photo_data": fetchedPhotoData == null ? [] : List<dynamic>.from(fetchedPhotoData!.map((x) => x)),
    "fetched_comments_data": List<dynamic>.from(fetchedCommentsData!.map((x) => x)),
  };
}

class FetchedProductSize {
  String? id;
  String? color;
  String? price;
  String? qnt;

  FetchedProductSize({
    this.id,
    this.color,
    this.price,
    this.qnt,
  });

  factory FetchedProductSize.fromJson(Map<String, dynamic> json) => FetchedProductSize(
    id: json["id"],
    color: json["color"],
    price: json["price"],
    qnt: json["qnt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "price": price,
    "qnt": qnt,
  };
}