class ItemsCartModel {
  String? _id;
  String? _image;
  String? _title;
  String? _titleEn;
  double? _price;
  int? _quantity;
  int? _maxQty;
  String? _variantId;
  String? _variantName;

  ItemsCartModel(this._id, this._image, this._title, this._titleEn, this._price,
      this._quantity, this._maxQty, this._variantId, this._variantName);

  int? get quantity => _quantity;
  int? get maxQty => _maxQty;
  set quantity(int? value) {
    _quantity = value;
  }

  set maxQty(int? value) {
    _maxQty = value;
  }

  double? get price => _price;
  String? get title => _title;
  String? get titleEn => _titleEn;
  String? get image => _image;
  String? get id => _id;
  String? get variantId => _variantId;
  String? get variantName => _variantName;

  ItemsCartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _titleEn = json['titleEn'];
    _image = json['image'];
    _price = json['price'].toDouble();
    _quantity = int.parse(json['quantity'].toString());
    _maxQty = int.parse(json['maxQty'].toString());
    _variantId = json['variantId'];
    _variantName = json['variantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['titleEn'] = this._titleEn;
    data['image'] = this._image;
    data['price'] = this._price;
    data['quantity'] = this._quantity;
    data['maxQty'] = this._maxQty;
    data['variantId'] = this._variantId;
    data['variantName'] = this._variantName;
    return data;
  }
}
