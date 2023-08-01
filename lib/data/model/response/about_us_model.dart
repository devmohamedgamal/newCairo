class AboutUsModel {
  AppInfo? fetchedAboutData;
  AboutUsModel({
    this.fetchedAboutData,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    fetchedAboutData: AppInfo.fromJson(json["fetched_about_data"]),
  );

  Map<String, dynamic> toJson() => {
    "fetched_about_data": fetchedAboutData!.toJson(),
  };
}

class AppInfo {
  String? id;
  String? title;
  String? description;
  String? tags;
  String? avatar;
  String? url;
  String? email;
  String? phone;
  String? mobile;
  String? hotline;
  String? facebook;
  String? twitter;
  String? telegram;
  String? youtube;
  String? rss;
  String? whatsapp;
  String? googleFrame;
  String? address;
  String? address2;
  String? phone2;
  String? mobile2;
  String? googleFrame2;
  String? titleEn;
  DateTime? updatedAt;
  String? descriptionEn;
  String? theme;
  dynamic offers;
  String? video;
  String? clients;
  String? multiGallery;
  String? news;
  String? vendors;
  String? lang2;
  String? fawry;
  String? master;
  String? stripe;
  String? paypal;
  String? cashApp;
  String? siteId;
  String? landingPage;
  String? merchantCode;
  String? hashKey;
  String? token;
  String? authorization;

  AppInfo({
    this.id,
    this.title,
    this.description,
    this.tags,
    this.avatar,
    this.url,
    this.email,
    this.phone,
    this.mobile,
    this.hotline,
    this.facebook,
    this.twitter,
    this.telegram,
    this.youtube,
    this.rss,
    this.whatsapp,
    this.googleFrame,
    this.address,
    this.address2,
    this.phone2,
    this.mobile2,
    this.googleFrame2,
    this.titleEn,
    this.updatedAt,
    this.descriptionEn,
    this.theme,
    this.offers,
    this.video,
    this.clients,
    this.multiGallery,
    this.news,
    this.vendors,
    this.lang2,
    this.fawry,
    this.master,
    this.stripe,
    this.paypal,
    this.cashApp,
    this.siteId,
    this.landingPage,
    this.merchantCode,
    this.hashKey,
    this.token,
    this.authorization,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    tags: json["tags"],
    avatar: json["avatar"],
    url: json["url"],
    email: json["email"],
    phone: json["phone"],
    mobile: json["mobile"],
    hotline: json["hotline"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    telegram: json["telegram"],
    youtube: json["youtube"],
    rss: json["rss"],
    whatsapp: json["whatsapp"],
    googleFrame: json["google_frame"],
    address: json["address"],
    address2: json["address2"],
    phone2: json["phone2"],
    mobile2: json["mobile2"],
    googleFrame2: json["google_frame2"],
    titleEn: json["titleEN"],
    updatedAt: DateTime.parse(json["updated_at"]),
    descriptionEn: json["descriptionEN"],
    theme: json["theme"],
    offers: json["offers"],
    video: json["video"],
    clients: json["clients"],
    multiGallery: json["multi_gallery"],
    news: json["news"],
    vendors: json["vendors"],
    lang2: json["lang2"],
    fawry: json["fawry"],
    master: json["master"],
    stripe: json["stripe"],
    paypal: json["paypal"],
    cashApp: json["cash_app"],
    siteId: json["site_id"],
    landingPage: json["landing_page"],
    merchantCode: json["merchant_code"],
    hashKey: json["hash_key"],
    token: json["token"],
    authorization: json["Authorization"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "tags": tags,
    "avatar": avatar,
    "url": url,
    "email": email,
    "phone": phone,
    "mobile": mobile,
    "hotline": hotline,
    "facebook": facebook,
    "twitter": twitter,
    "telegram": telegram,
    "youtube": youtube,
    "rss": rss,
    "whatsapp": whatsapp,
    "google_frame": googleFrame,
    "address": address,
    "address2": address2,
    "phone2": phone2,
    "mobile2": mobile2,
    "google_frame2": googleFrame2,
    "titleEN": titleEn,
    "updated_at": updatedAt!.toIso8601String(),
    "descriptionEN": descriptionEn,
    "theme": theme,
    "offers": offers,
    "video": video,
    "clients": clients,
    "multi_gallery": multiGallery,
    "news": news,
    "vendors": vendors,
    "lang2": lang2,
    "fawry": fawry,
    "master": master,
    "stripe": stripe,
    "paypal": paypal,
    "cash_app": cashApp,
    "site_id": siteId,
    "landing_page": landingPage,
    "merchant_code": merchantCode,
    "hash_key": hashKey,
    "token": token,
    "Authorization": authorization,
  };
}