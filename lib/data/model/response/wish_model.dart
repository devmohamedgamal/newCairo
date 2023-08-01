class WishModel {
  List<Wish>? wish;
  WishModel({this.wish});

  factory WishModel.fromJson(Map<String, dynamic> json) => WishModel(
      wish: List<Wish>.from(json["wish"].map((x) => Wish.fromJson(x))),
  );

  Map<String, dynamic> toJson() =>{
    'wish': List<dynamic>.from(wish!.map((x) => x.toJson())),
  };
}

class Wish {
  String? id;
  String? categoryId;
  String? title;
  String? pavatar;
  dynamic pdfFile;
  String? description;
  String? details;
  dynamic atime;
  String? adate;
  dynamic views;
  String? pstatus;
  String? tags;
  String? url;
  String? priceBefore;
  String? price;
  String? mostSold;
  String? specialOffer;
  String? homepage;
  dynamic stock;
  dynamic kinds;
  String? quantity;
  String? colors;
  String? size;
  String? shipping;
  String? offerEnd;
  String? vendorid;
  String? addby;
  String? rate;
  String? titleEN;
  String? updatedAt;
  String? descriptionEN;
  String? detailsEN;
  String? wishId;
  String? productId;
  String? customerId;
  String? edate;

  Wish(
      {this.id,
        this.categoryId,
        this.title,
        this.pavatar,
        this.pdfFile,
        this.description,
        this.details,
        this.atime,
        this.adate,
        this.views,
        this.pstatus,
        this.tags,
        this.url,
        this.priceBefore,
        this.price,
        this.mostSold,
        this.specialOffer,
        this.homepage,
        this.stock,
        this.kinds,
        this.quantity,
        this.colors,
        this.size,
        this.shipping,
        this.offerEnd,
        this.vendorid,
        this.addby,
        this.rate,
        this.titleEN,
        this.updatedAt,
        this.descriptionEN,
        this.detailsEN,
        this.wishId,
        this.productId,
        this.customerId,
        this.edate});

  factory Wish.fromJson(Map<String, dynamic> json) => Wish(
    id: json['id'],
    categoryId: json['category_id'],
    title: json['title'],
    pavatar: json['pavatar'],
    pdfFile: json['pdf_file'],
    description: json['description'],
    details: json['details'],
    atime: json['atime'],
    adate: json['adate'],
    views: json['views'],
    pstatus: json['pstatus'],
    tags: json['tags'],
    url: json['url'],
    priceBefore: json['price_before'],
    price: json['price'],
    mostSold: json['most_sold'],
    specialOffer: json['special_offer'],
    homepage: json['homepage'],
    stock: json['stock'],
    kinds: json['kinds'],
    quantity: json['quantity'],
    colors: json['colors'],
    size: json['size'],
    shipping: json['shipping'],
    offerEnd: json['offer_end'],
    vendorid: json['vendorid'],
    addby: json['Addby'],
    rate: json['rate'],
    titleEN: json['titleEN'],
    updatedAt: json['updated_at'],
    descriptionEN: json['descriptionEN'],
    detailsEN: json['detailsEN'],
    wishId: json['wish_id'],
    productId: json['product_id'],
    customerId: json['customer_id'],
    edate: json['edate'],
  );

  Map<String, dynamic> toJson() =>{
    'id': this.id,
    'category_id': this.categoryId,
    'title': this.title,
    'pavatar': this.pavatar,
    'pdf_file': this.pdfFile,
    'description': this.description,
    'details': this.details,
    'atime': this.atime,
    'adate': this.adate,
    'views': this.views,
    'pstatus': this.pstatus,
    'tags': this.tags,
    'url': this.url,
    'price_before': this.priceBefore,
    'price': this.price,
    'most_sold': this.mostSold,
    'special_offer': this.specialOffer,
    'homepage': this.homepage,
    'stock': this.stock,
    'kinds': this.kinds,
    'quantity': this.quantity,
    'colors': this.colors,
    'size': this.size,
    'shipping': this.shipping,
    'offer_end': this.offerEnd,
    'vendorid': this.vendorid,
    'Addby': this.addby,
    'rate': this.rate,
    'titleEN': this.titleEN,
    'updated_at': this.updatedAt,
    'descriptionEN': this.descriptionEN,
    'detailsEN': this.detailsEN,
    'wish_id': this.wishId,
    'product_id': this.productId,
    'customer_id': this.customerId,
    'edate': this.edate,
  };
}