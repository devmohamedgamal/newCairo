class ReviewModel {
  int? _id;
  int? _productId;
  int? _customerId;
  String? _comment;
  List<String>? _attachment;
  int? _rating;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  ReviewModel(
      {int? id,
        int? productId,
        int? customerId,
        String? comment,
        List<String>? attachment,
        int? rating,
        int? status,
        String? createdAt,
        String? updatedAt,
        }) {
    this._id = id;
    this._productId = productId;
    this._customerId = customerId;
    this._comment = comment;
    this._attachment = attachment;
    this._rating = rating;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get id => _id;
  int? get productId => _productId;
  int? get customerId => _customerId;
  String? get comment => _comment;
  List<String>? get attachment => _attachment;
  int? get rating => _rating;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _customerId = json['customer_id'];
    _comment = json['comment'];
    _attachment = json['attachment'].cast<String>();
    _rating = json['rating'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['product_id'] = this._productId;
    data['customer_id'] = this._customerId;
    data['comment'] = this._comment;
    data['rating'] = this._rating;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
