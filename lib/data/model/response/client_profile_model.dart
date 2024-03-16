class ClientProfileModel {
  List<FetchedOrder>? orders;
  ClientData? clientData;
  List<Wish>? wish;

  ClientProfileModel({
    this.orders,
    this.clientData,
    this.wish,
  });

  factory ClientProfileModel.fromJson(Map<String, dynamic> json) =>
      ClientProfileModel(
        orders: List<FetchedOrder>.from(
            json["fetched_orders"].map((x) => FetchedOrder.fromJson(x))),
        clientData: ClientData.fromJson(json["clientdata"]),
        wish: List<Wish>.from(json["wish"].map((x) => Wish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fetched_orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
        "clientdata": clientData!.toJson(),
        "wish": List<dynamic>.from(wish!.map((x) => x.toJson())),
      };
}

class ClientData {
  String? clientId;
  String? clientName;
  String? fullName;
  String? email;
  String? mobile;
  String? address;
  String? password;
  String? clientStatus;
  DateTime? addDate;
  String? avatar;
  String? uniId;
  DateTime? updatedAt;
  String? clientStatus2;
  dynamic login;
  String? tokenId;
  ClientData({
    this.clientId,
    this.clientName,
    this.fullName,
    this.email,
    this.mobile,
    this.address,
    this.password,
    this.clientStatus,
    this.addDate,
    this.avatar,
    this.uniId,
    this.updatedAt,
    this.clientStatus2,
    this.login,
    this.tokenId,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) => ClientData(
        clientId: json["clientid"],
        clientName: json["clientname"],
        fullName: json["fullname"],
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        password: json["password"],
        clientStatus: json["clientstatus"],
        addDate: DateTime.parse(json["adddate"]),
        avatar: json["avatar"],
        uniId: json["uniid"],
        updatedAt: DateTime.parse(json["updated_at"]),
        clientStatus2: json["clientstatus2"],
        login: json["login"],
        tokenId: json["token_id"],
      );

  Map<String, dynamic> toJson() => {
        "clientid": clientId,
        "clientname": clientName,
        "fullname": fullName,
        "email": email,
        "mobile": mobile,
        "address": address,
        "password": password,
        "clientstatus": clientStatus,
        "adddate": addDate!.toIso8601String(),
        "avatar": avatar,
        "uniid": uniId,
        "updated_at": updatedAt!.toIso8601String(),
        "clientstatus2": clientStatus2,
        "login": login,
        "token_id": tokenId,
      };
}

class FetchedOrder {
  String? id;
  DateTime? adate;
  String? note;
  String? way;
  String? shippingId;
  String? customerId;
  String? status;
  String? paymentStatus;
  String? paymentMethod;
  String? orderAddress;
  String? orderMobile;
  String? lat;
  String? lng;
  String? fullAddress;
  String? clientId;
  String? orderPrice;
  List<OrderItem>? orderItems;

  FetchedOrder({
    this.id,
    this.adate,
    this.note,
    this.way,
    this.shippingId,
    this.customerId,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.orderAddress,
    this.orderMobile,
    this.lat,
    this.lng,
    this.fullAddress,
    this.clientId,
    this.orderPrice,
    this.orderItems,
  });

  factory FetchedOrder.fromJson(Map<String, dynamic> json) => FetchedOrder(
        id: json["id"],
        adate: DateTime.parse(json["adate"]),
        note: json["note"],
        way: json["way"],
        shippingId: json["shipping_id"],
        customerId: json["customer_id"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        orderAddress: json["order_address"],
        orderMobile: json["order_mobile"],
        lat: json["lat"],
        lng: json["lng"],
        fullAddress: json["full_address"],
        clientId: json["client_id"],
        orderPrice: json["order_price"] == null ? null : json["order_price"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adate": adate!.toIso8601String(),
        "note": note,
        "way": way,
        "shipping_id": shippingId,
        "customer_id": customerId,
        "status": status,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "order_address": orderAddress,
        "order_mobile": orderMobile,
        "lat": lat,
        "lng": lng,
        "full_address": fullAddress,
        "client_id": clientId,
        "order_price": orderPrice == null ? null : orderPrice,
        "order_items": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class OrderItem {
  String? id;
  String? orderId;
  String? productId;
  String? qty;
  String? price;
  String? kind;
  dynamic colors;
  dynamic size;
  String? kindId;
  String? productName;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.qty,
    this.price,
    this.kind,
    this.colors,
    this.size,
    this.kindId,
    this.productName,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["orderid"],
        productId: json["productid"],
        qty: json["qty"],
        price: json["price"],
        kind: json["kind"],
        colors: json["colors"],
        size: json["size"],
        kindId: json["kind_id"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderid": orderId,
        "productid": productId,
        "qty": qty,
        "price": price,
        "kind": kind,
        "colors": colors,
        "size": size,
        "kind_id": kindId,
        "product_name": productName,
      };
}

class Wish {
  String? id;
  String? categoryId;
  String? title;
  String? pavatar;
  Null? pdfFile;
  String? description;
  String? details;
  Null? atime;
  String? adate;
  Null? views;
  String? pstatus;
  String? tags;
  Null? url;
  String? priceBefore;
  String? price;
  Null? mostSold;
  String? specialOffer;
  String? homepage;
  Null? stock;
  Null? kinds;
  Null? quantity;
  Null? colors;
  Null? size;
  String? shipping;
  String? offerEnd;
  String? vendorid;
  Null? addby;
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

  Wish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    pavatar = json['pavatar'];
    pdfFile = json['pdf_file'];
    description = json['description'];
    details = json['details'];
    atime = json['atime'];
    adate = json['adate'];
    views = json['views'];
    pstatus = json['pstatus'];
    tags = json['tags'];
    url = json['url'];
    priceBefore = json['price_before'];
    price = json['price'];
    mostSold = json['most_sold'];
    specialOffer = json['special_offer'];
    homepage = json['homepage'];
    stock = json['stock'];
    kinds = json['kinds'];
    quantity = json['quantity'];
    colors = json['colors'];
    size = json['size'];
    shipping = json['shipping'];
    offerEnd = json['offer_end'];
    vendorid = json['vendorid'];
    addby = json['Addby'];
    rate = json['rate'];
    titleEN = json['titleEN'];
    updatedAt = json['updated_at'];
    descriptionEN = json['descriptionEN'];
    detailsEN = json['detailsEN'];
    wishId = json['wish_id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    edate = json['edate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['pavatar'] = this.pavatar;
    data['pdf_file'] = this.pdfFile;
    data['description'] = this.description;
    data['details'] = this.details;
    data['atime'] = this.atime;
    data['adate'] = this.adate;
    data['views'] = this.views;
    data['pstatus'] = this.pstatus;
    data['tags'] = this.tags;
    data['url'] = this.url;
    data['price_before'] = this.priceBefore;
    data['price'] = this.price;
    data['most_sold'] = this.mostSold;
    data['special_offer'] = this.specialOffer;
    data['homepage'] = this.homepage;
    data['stock'] = this.stock;
    data['kinds'] = this.kinds;
    data['quantity'] = this.quantity;
    data['colors'] = this.colors;
    data['size'] = this.size;
    data['shipping'] = this.shipping;
    data['offer_end'] = this.offerEnd;
    data['vendorid'] = this.vendorid;
    data['Addby'] = this.addby;
    data['rate'] = this.rate;
    data['titleEN'] = this.titleEN;
    data['updated_at'] = this.updatedAt;
    data['descriptionEN'] = this.descriptionEN;
    data['detailsEN'] = this.detailsEN;
    data['wish_id'] = this.wishId;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['edate'] = this.edate;
    return data;
  }
}
