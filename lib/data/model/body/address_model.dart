class AddressModel {
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;

  AddressModel({this.addressType,this.address,
    this.city,this.zip,this.phone});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    return data;
  }
}