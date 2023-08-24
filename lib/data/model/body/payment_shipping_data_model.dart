class PaymentShippingDataModel {
  late final String firstName;
  late final String lastName;
  late final String? email;
  late final String? phoneNumber;
  late final String extraDescription;
  late final String street;
  late final String floor;
  late final String building;
  late final String apartment;
  late final String city;
  late final String country;

  PaymentShippingDataModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.extraDescription = '',
    this.street = '-',
    this.floor = '-',
    this.building = '-',
    this.apartment = '-',
    this.city = '-',
    this.country = '-',
  });

  Map toJson(){
    return {
      'email': email??'-',
      'phone_number': phoneNumber??'-',
      'first_name': firstName,
      'last_name': lastName,
      'extra_description': extraDescription,
      'street': street,
      'floor': floor,
      'building': building,
      'apartment': apartment,
      'city': city,
      'country': country,
    };
  }
}