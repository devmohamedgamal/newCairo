class Product {
  String? id;
  dynamic categoryId;
  dynamic projectId;
  String? title;
  String? pavatar;
  dynamic pdfFile;
  String? description;
  dynamic details;
  dynamic atime;
  String? adate;
  dynamic views;
  String? pstatus;
  dynamic tags;
  dynamic url;
  dynamic priceBefore;
  String? price;
  dynamic mostSold;
  dynamic specialOffer;
  dynamic homepage;
  dynamic stock;
  dynamic kinds;
  String? quantity;
  dynamic colors;
  dynamic size;
  dynamic shipping;
  dynamic shipping2;
  dynamic shipping3;
  String? vendorid;
  dynamic addby;
  dynamic rate;
  dynamic titleEn;
  String? updatedAt;
  dynamic descriptionEn;
  dynamic detailsEn;
  String? typeId;
  String? governId;
  String? area;
  dynamic tags2;
  String? count1;
  String? count2;
  String? count3;
  String? count4;
  dynamic specialOfferText1;
  dynamic specialOfferText2;
  dynamic specialOfferText3;
  dynamic specialOfferText4;
  dynamic stockText1;
  dynamic stockText2;
  dynamic stockText3;
  dynamic homepageText1;
  dynamic homepageText2;
  dynamic videoCode;
  dynamic mapCode;
  dynamic unitCode;
  String? adtype;
  dynamic carType;
  dynamic otherType;
  String? paytype;
  String? phone;
  String? whatsapp;
  dynamic serviceType;
  dynamic dateto;
  dynamic remaining;
  dynamic number;
  dynamic poolKind;
  String? clientid;
  dynamic marketid;
  String? productTyp;

  Product({
    this.id,
    this.categoryId,
    this.projectId,
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
    this.shipping2,
    this.shipping3,
    this.vendorid,
    this.addby,
    this.rate,
    this.titleEn,
    this.updatedAt,
    this.descriptionEn,
    this.detailsEn,
    this.typeId,
    this.governId,
    this.area,
    this.tags2,
    this.count1,
    this.count2,
    this.count3,
    this.count4,
    this.specialOfferText1,
    this.specialOfferText2,
    this.specialOfferText3,
    this.specialOfferText4,
    this.stockText1,
    this.stockText2,
    this.stockText3,
    this.homepageText1,
    this.homepageText2,
    this.videoCode,
    this.mapCode,
    this.unitCode,
    this.adtype,
    this.carType,
    this.otherType,
    this.paytype,
    this.phone,
    this.whatsapp,
    this.serviceType,
    this.dateto,
    this.remaining,
    this.number,
    this.poolKind,
    this.clientid,
    this.marketid,
    this.productTyp,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String?,
        categoryId: json['category_id'] as dynamic,
        projectId: json['project_id'] as dynamic,
        title: json['title'] as String?,
        pavatar: json['pavatar'] as String?,
        pdfFile: json['pdf_file'] as dynamic,
        description: json['description'] as String?,
        details: json['details'] as dynamic,
        atime: json['atime'] as dynamic,
        adate: json['adate'] as String?,
        views: json['views'] as dynamic,
        pstatus: json['pstatus'] as String?,
        tags: json['tags'] as dynamic,
        url: json['url'] as dynamic,
        priceBefore: json['price_before'] as dynamic,
        price: json['price'] as String?,
        mostSold: json['most_sold'] as dynamic,
        specialOffer: json['special_offer'] as dynamic,
        homepage: json['homepage'] as dynamic,
        stock: json['stock'] as dynamic,
        kinds: json['kinds'] as dynamic,
        quantity: json['quantity'] as String?,
        colors: json['colors'] as dynamic,
        size: json['size'] as dynamic,
        shipping: json['shipping'] as dynamic,
        shipping2: json['shipping2'] as dynamic,
        shipping3: json['shipping3'] as dynamic,
        vendorid: json['vendorid'] as String?,
        addby: json['Addby'] as dynamic,
        rate: json['rate'] as dynamic,
        titleEn: json['titleEN'] as dynamic,
        updatedAt: json['updated_at'] as String?,
        descriptionEn: json['descriptionEN'] as dynamic,
        detailsEn: json['detailsEN'] as dynamic,
        typeId: json['type_id'] as String?,
        governId: json['govern_id'] as String?,
        area: json['area'] as String?,
        tags2: json['tags2'] as dynamic,
        count1: json['count1'] as String?,
        count2: json['count2'] as String?,
        count3: json['count3'] as String?,
        count4: json['count4'] as String?,
        specialOfferText1: json['special_offer_text1'] as dynamic,
        specialOfferText2: json['special_offer_text2'] as dynamic,
        specialOfferText3: json['special_offer_text3'] as dynamic,
        specialOfferText4: json['special_offer_text4'] as dynamic,
        stockText1: json['stock_text1'] as dynamic,
        stockText2: json['stock_text2'] as dynamic,
        stockText3: json['stock_text3'] as dynamic,
        homepageText1: json['homepage_text1'] as dynamic,
        homepageText2: json['homepage_text2'] as dynamic,
        videoCode: json['video_code'] as dynamic,
        mapCode: json['map_code'] as dynamic,
        unitCode: json['unit_code'] as dynamic,
        adtype: json['adtype'] as String?,
        carType: json['car_type'] as dynamic,
        otherType: json['other_type'] as dynamic,
        paytype: json['paytype'] as String?,
        phone: json['phone'] as String?,
        whatsapp: json['whatsapp'] as String?,
        serviceType: json['service_type'] as dynamic,
        dateto: json['dateto'] as dynamic,
        remaining: json['remaining'] as dynamic,
        number: json['number'] as dynamic,
        poolKind: json['pool_kind'] as dynamic,
        clientid: json['clientid'] as String?,
        marketid: json['marketid'] as dynamic,
        productTyp: json['product_typ'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'project_id': projectId,
        'title': title,
        'pavatar': pavatar,
        'pdf_file': pdfFile,
        'description': description,
        'details': details,
        'atime': atime,
        'adate': adate,
        'views': views,
        'pstatus': pstatus,
        'tags': tags,
        'url': url,
        'price_before': priceBefore,
        'price': price,
        'most_sold': mostSold,
        'special_offer': specialOffer,
        'homepage': homepage,
        'stock': stock,
        'kinds': kinds,
        'quantity': quantity,
        'colors': colors,
        'size': size,
        'shipping': shipping,
        'shipping2': shipping2,
        'shipping3': shipping3,
        'vendorid': vendorid,
        'Addby': addby,
        'rate': rate,
        'titleEN': titleEn,
        'updated_at': updatedAt,
        'descriptionEN': descriptionEn,
        'detailsEN': detailsEn,
        'type_id': typeId,
        'govern_id': governId,
        'area': area,
        'tags2': tags2,
        'count1': count1,
        'count2': count2,
        'count3': count3,
        'count4': count4,
        'special_offer_text1': specialOfferText1,
        'special_offer_text2': specialOfferText2,
        'special_offer_text3': specialOfferText3,
        'special_offer_text4': specialOfferText4,
        'stock_text1': stockText1,
        'stock_text2': stockText2,
        'stock_text3': stockText3,
        'homepage_text1': homepageText1,
        'homepage_text2': homepageText2,
        'video_code': videoCode,
        'map_code': mapCode,
        'unit_code': unitCode,
        'adtype': adtype,
        'car_type': carType,
        'other_type': otherType,
        'paytype': paytype,
        'phone': phone,
        'whatsapp': whatsapp,
        'service_type': serviceType,
        'dateto': dateto,
        'remaining': remaining,
        'number': number,
        'pool_kind': poolKind,
        'clientid': clientid,
        'marketid': marketid,
        'product_typ': productTyp,
      };
}
