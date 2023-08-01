class OrderModel {
  List<Order>? fetchedOrders;

  OrderModel({
    this.fetchedOrders,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    fetchedOrders: List<Order>.from(json["fetched_orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fetched_orders": List<dynamic>.from(fetchedOrders!.map((x) => x.toJson())),
  };
}

class Order {
  String? id;
  DateTime? adate;
  String? note;
  String? way;
  String? shippingId;
  String? customerId;
  String? status;
  dynamic paymentStatus;
  String? paymentMethod;
  String? orderAddress;
  String? orderMobile;
  String? lat;
  String? lng;
  String? fullAddress;
  String? clientId;
  String? orderPrice;
  String? shippingCost;
  List<OrderItem>? orderItems;

  Order({
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
    this.shippingCost,
    this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
    orderPrice: json["order_price"],
    shippingCost: json["shipping_cost"],
    orderItems: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
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
    "order_price": orderPrice,
    "shipping_cost": shippingCost,
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
  String? kindName;
  String? pavatar;
  String? productName;
  String? productNameEN;
  String? sizeId;
  String? sizeName;

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
    this.kindName,
    this.pavatar,
    this.productName,
    this.productNameEN,
    this.sizeId,
    this.sizeName,
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
    kindName: json["kind_name"],
    pavatar: json["pavatar"],
    productName: json["product_name"],
    productNameEN: json["product_nameEN"],
    sizeId: json["size_id"],
    sizeName: json["size_name"],
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
    "kind_name": kindName,
    "pavatar": pavatar,
    "product_name": productName,
    "product_nameEN": productNameEN,
    "size_id": sizeId,
    "size_name": sizeName,
  };
}