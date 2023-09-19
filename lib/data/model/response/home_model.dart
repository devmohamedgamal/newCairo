class HomeModel {
  List<Sliders>? sliders;
  List<Product>? specialOffers;
  List<Category>? category;
  Post? postColor;
  Post? postSize;
  Post? postKind;
  List<Product>? products;

  HomeModel({
    this.sliders,
    this.specialOffers,
    this.category,
    this.postColor,
    this.postSize,
    this.postKind,
    this.products,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
    sliders: List<Sliders>.from(json["fetched_slider_data"].map((x) => Sliders.fromJson(x))),
    specialOffers: List<Product>.from(json["spcial_offers"].where((e) => e['offer_end']?.isNotEmpty == true).map((x) => Product.fromJson(x))),
    category: List<Category>.from(json["fetched_category_data"].map((x) => Category.fromJson(x))),
    postColor: Post.fromJson(json["post_color"]),
    postSize: Post.fromJson(json["post_size"]),
    postKind: Post.fromJson(json["post_kind"]),
    products: List<Product>.from(json["fetched_home_products"].map((x) => Product.fromJson(x))),
  );
  }

  Map<String, dynamic> toJson() => {
    "fetched_slider_data": List<dynamic>.from(sliders!.map((x) => x.toJson())),
    "spcial_offers": List<dynamic>.from(specialOffers!.map((x) => x.toJson())),
    "fetched_category_data": List<dynamic>.from(category!.map((x) => x.toJson())),
    "post_color": postColor!.toJson(),
    "post_size": postSize!.toJson(),
    "post_kind": postKind!.toJson(),
    "fetched_home_products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Sliders {
  String? sliderId;
  String? title;
  String? avatar;
  String? description;
  String? titleEn;
  dynamic updatedAt;
  String? descriptionEn;
  String? detailsEn;
  String? status;
  String? link;

  Sliders({
    this.sliderId,
    this.title,
    this.avatar,
    this.description,
    this.titleEn,
    this.updatedAt,
    this.descriptionEn,
    this.detailsEn,
    this.status,
    this.link,
  });

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
    sliderId: json["slider_id"],
    title: json["title"],
    avatar: json["avatar"],
    description: json["description"],
    titleEn: json["titleEN"],
    updatedAt: json["updated_at"],
    descriptionEn: json["descriptionEN"],
    detailsEn: json["detailsEN"],
    status: json["status"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "slider_id": sliderId,
    "title": title,
    "avatar": avatar,
    "description": description,
    "titleEN": titleEn,
    "updated_at": updatedAt,
    "descriptionEN": descriptionEn,
    "detailsEN": detailsEn,
    "status": status,
    "link": link,
  };
}

class SpecialOffers {
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
  String? stock;
  String? kinds;
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

  SpecialOffers(
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
        this.detailsEN});

  factory SpecialOffers.fromJson(Map<String, dynamic> json) =>SpecialOffers(
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
  );

  Map<String, dynamic> toJson() => {
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
  };
}

class Category {
  String? categoryId;
  String? catTitle;
  String? avatar;
  String? describtion;
  String? titleEN;
  String? updatedAt;
  String? descriptionEN;
  String? detailsEN;
  String? status;
  String? typeId;

  Category(
      {this.categoryId,
        this.catTitle,
        this.avatar,
        this.describtion,
        this.titleEN,
        this.updatedAt,
        this.descriptionEN,
        this.detailsEN,
        this.status,
        this.typeId});

  factory Category.fromJson(Map<String, dynamic> json) =>Category(
    categoryId: json['category_id'],
    catTitle: json['cat_title'],
    avatar: json['avatar'],
    describtion: json['describtion'],
    titleEN: json['titleEN'],
    updatedAt: json['updated_at'],
    descriptionEN: json['descriptionEN'],
    detailsEN: json['detailsEN'],
    status: json['status'],
    typeId: json['type_id'],
  );

  Map<String, dynamic> toJson()=> {
    'category_id': this.categoryId,
    'cat_title': this.catTitle,
    'avatar': this.avatar,
    'describtion': this.describtion,
    'titleEN': this.titleEN,
    'updated_at': this.updatedAt,
    'descriptionEN': this.descriptionEN,
    'detailsEN': this.detailsEN,
    'status': this.status,
    'type_id': this.typeId,
  };
}

class Product {
  String? id;
  String? categoryId;
  String? title;
  String? pavatar;
  dynamic pdfFile;
  String? description;
  String? details;
  dynamic atime;
  DateTime? adate;
  dynamic views;
  String? pstatus;
  String? tags;
  String? url;
  String? priceBefore;
  String? price;
  String? mostSold;
  String? specialOffer;
  Homepage? homepage;
  String? stock;
  String? kinds;
  String? quantity;
  String? colors;
  String? size;
  String? shipping;
  String? offerEnd;
  String? vendorid;
  String? addby;
  String? rate;
  String? titleEn;
  DateTime? updatedAt;
  DescriptionEn? descriptionEn;
  String? detailsEn;
  bool? productinwish;
  List<FetchedProductKind>? fetchedProductKinds;

  String get getPrice => price??'';

  Product({
    this.id,
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
    this.titleEn,
    this.updatedAt,
    this.descriptionEn,
    this.detailsEn,
    this.productinwish,
    this.fetchedProductKinds,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    pavatar: json["pavatar"],
    pdfFile: json["pdf_file"],
    description: json["description"],
    details: json["details"],
    atime: json["atime"],
    adate: json["adate"] == null ? null : DateTime.parse(json["adate"]),
    views: json["views"],
    pstatus: json["pstatus"],
    tags: json["tags"],
    url: json["url"],
    priceBefore: json["price_before"],
    price: json["price"],
    mostSold: json["most_sold"] == null ? null : json["most_sold"],
    specialOffer: json["special_offer"] == null ? null : json["special_offer"],
    homepage: json["homepage"] == null ? null : homepageValues.map![json["homepage"]],
    stock: json["stock"] == null ? null : json["stock"],
    kinds: json["kinds"],
    quantity: json["quantity"],
    colors: json["colors"],
    size: json["size"],
    shipping: json["shipping"],
    offerEnd: json["offer_end"],
    vendorid: json["vendorid"],
    addby: json["Addby"],
    rate: json["rate"] == null ? null : json["rate"],
    titleEn: json["titleEN"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    descriptionEn: descriptionEnValues.map![json["descriptionEN"]],
    detailsEn: json["detailsEN"],
    productinwish: json["productinwish"] == null ? null : json["productinwish"],
    fetchedProductKinds: json["fetched_product_kinds"] == null ? null : List<FetchedProductKind>.from(json["fetched_product_kinds"].map((x) => FetchedProductKind.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "pavatar": pavatar,
    "pdf_file": pdfFile,
    "description": description,
    "details": details,
    "atime": atime,
    "adate": adate!.toIso8601String(),
    "views": views,
    "pstatus": pstatus,
    "tags": tags,
    "url": url,
    "price_before": priceBefore,
    "price": price,
    "most_sold": mostSold == null ? null : mostSold,
    "special_offer": specialOffer == null ? null : specialOffer,
    "homepage": homepage == null ? null : homepageValues.reverse![homepage],
    "stock": stock == null ? null : stock,
    "kinds": kinds,
    "quantity": quantity,
    "colors": colors,
    "size": size,
    "shipping": shipping,
    "offer_end": offerEnd,
    "vendorid": vendorid,
    "Addby": addby,
    "rate": rate == null ? null : rate,
    "titleEN": titleEn,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "descriptionEN": descriptionEnValues.reverse![descriptionEn],
    "detailsEN": detailsEn,
    "productinwish": productinwish == null ? null : productinwish,
    "fetched_product_kinds": fetchedProductKinds == null
        ? null
        : List<dynamic>.from(fetchedProductKinds!.map((x) => x.toJson())),
  };
}

enum DescriptionEn {EMPTY, DESCRIPTION_EN }

final descriptionEnValues = EnumValues({
  "    ": DescriptionEn.DESCRIPTION_EN,
  "  ": DescriptionEn.EMPTY
});

class FetchedProductKind {
  String? kindId;
  String? productId;
  String? size;
  String? color;
  String? kindName;
  String? qnt;
  String? price;
  String? fullqnt;
  String? priceBefore;
  String? kindColor;
  String? sizeName;

  FetchedProductKind({
    this.kindId,
    this.productId,
    this.size,
    this.color,
    this.kindName,
    this.qnt,
    this.price,
    this.fullqnt,
    this.priceBefore,
    this.kindColor,
    this.sizeName,
  });

  factory FetchedProductKind.fromJson(Map<String, dynamic> json) => FetchedProductKind(
    kindId: json["kind_id"],
    productId: json["product_id"],
    size: json["size"],
    color: json["color"],
    kindName: json["kind_name"],
    qnt: json["qnt"],
    price: json["price"],
    fullqnt: json["fullqnt"],
    priceBefore: json["price_before"],
    kindColor: json["kind_color"],
    sizeName: json["size_name"],
  );

  Map<String, dynamic> toJson() => {
    "kind_id": kindId,
    "product_id": productId,
    "size": size,
    "color": color,
    "kind_name": kindName,
    "qnt": qnt,
    "price": price,
    "fullqnt": fullqnt,
    "price_before": priceBefore,
    "kind_color": kindColor,
    "size_name": sizeName,
  };
}

enum Homepage {HOMEPAGE}

final homepageValues = EnumValues({
  "homepage": Homepage.HOMEPAGE
});

class Post {
  String? name;
  Post({this.name,});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}