import 'package:lemirageelevators/helper/api_data_helper.dart';

class OrderModel {
  List<Order>? fetchedOrders;

  OrderModel({
    this.fetchedOrders,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        fetchedOrders: List<Order>.from(
            json["fetched_orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fetched_orders":
            List<dynamic>.from(fetchedOrders!.map((x) => x.toJson())),
      };
}

class Order {
  // String? shippingId;
  // String? customerId;
  // String? paymentMethod;
  // String? orderAddress;
  // String? lat;
  // String? lng;
  // String? clientId;

  late String id;
  late DateTime? date;
  late String note;
  late String way;
  late String status;
  late dynamic paymentStatus;
  late String orderMobile;
  late String fullAddress;
  late List<OrderItem> orderItems;

  // order: 850, shippingCose: 39, promo: -170, total payable: 680

  // Price section
  late num orderPrice;
  late num? totalPrice;
  late num discountAmount;
  late num shippingPrice;

  String getTotalPrice() =>
      totalPrice?.toString() ??
      (orderPrice - discountAmount + shippingPrice).toString();

  String getOrderPrice() {
    if (orderPrice > 0) {
      return '$orderPrice';
    } else if (totalPrice == null) {
      return '-';
    }

    return (totalPrice! + discountAmount - shippingPrice).toString();
  }

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.parse(json["adate"]);
    note = json['note'];
    way = json['way'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    orderMobile = json['order_mobile'] ?? '';
    fullAddress = json['full_address'] ?? '';
    orderItems = List<OrderItem>.from(
        json["order_items"].map((x) => OrderItem.fromJson(x)));

    orderPrice = ApiDataHelper.getNum(json['order_price']) ?? 0;
    json['order_price'] ?? '0.00';
    totalPrice = ApiDataHelper.getNum(json['total']);
    discountAmount = ApiDataHelper.getNum(json['discount']) ?? 0;
    shippingPrice = ApiDataHelper.getNum(json['shipping_cost']) ?? 0;

    // orderPrice = json['order_price'] ?? '0.00';
    // totalPrice = json['total'];
    // discountAmount = json['discount'] ?? 0;
    // shippingPrice = json['shipping_cost'] ?? '0.00';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'adate': date,
        'note': note,
        'way': way,
        'status': status,
        'payment_status': paymentStatus,
        'order_mobile': orderMobile,
        'full_address': fullAddress,
        "order_items": List.from(orderItems.map((x) => x.toJson())),
        'order_price': '$orderPrice',
        'total': '$totalPrice',
        'discount': '$discountAmount',
        'shipping_cost': '$shippingPrice',
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
