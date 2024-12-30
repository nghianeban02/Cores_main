class Customer {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? phone1;
  String? phone2;
  String? street;
  int? customerType;
  int? wardId;
  String? wardName;
  int? districtId;
  String? districtName;
  int? cityId;
  String? cityName;
  String? addressFull;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phone1,
    this.phone2,
    this.street,
    this.customerType,
    this.wardId,
    this.wardName,
    this.districtId,
    this.districtName,
    this.cityId,
    this.cityName,
    this.addressFull,
  });
  Customer copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phone1,
    String? phone2,
    String? street,
    int? customerType,
    int? wardId,
    String? wardName,
    int? districtId,
    String? districtName,
    int? cityId,
    String? cityName,
    String? addressFull,
  }) {
    return Customer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
      street: street ?? this.street,
      customerType: customerType ?? this.customerType,
      wardId: wardId ?? this.wardId,
      wardName: wardName ?? this.wardName,
      districtId: districtId ?? this.districtId,
      districtName: districtName ?? this.districtName,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      addressFull: addressFull ?? this.addressFull,
    );
  }

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    email = json['email'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    street = json['street'];
    customerType = json['customerType'];
    wardId = json['wardId'];
    wardName = json['wardName'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    addressFull = json['addressFull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['street'] = this.street;
    data['customerType'] = this.customerType ?? 0;
    data['wardId'] = this.wardId;
    data['wardName'] = this.wardName;
    data['districtId'] = this.districtId;
    data['districtName'] = this.districtName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['addressFull'] = this.addressFull;
    return data;
  }
}
