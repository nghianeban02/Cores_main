import 'customer_model.dart';

class ActiveModel {
  String? note;
  String? code;
  int? modelId;
  String? serial;
  String? dayBuy;
  int? customerId;
  int? repairingCityId;
  int? repairingDistrictId;
  int? repairingWardId;
  String? repairingAddressFull;
  String? repairingStreet;
  String? phoneActive;
  String? image;
  Customer? customer;

  ActiveModel(
      {this.note,
      this.code,
      this.modelId,
      this.serial,
      this.dayBuy,
      this.customerId,
      this.repairingCityId,
      this.repairingDistrictId,
      this.repairingWardId,
      this.repairingAddressFull,
      this.repairingStreet,
      this.phoneActive,
      this.image,
      this.customer});

  ActiveModel copyWith({
    String? note,
    String? code,
    int? modelId,
    String? serial,
    String? dayBuy,
    int? customerId,
    int? repairingCityId,
    int? repairingDistrictId,
    int? repairingWardId,
    String? repairingAddressFull,
    String? repairingStreet,
    String? phoneActive,
    String? image,
    Customer? customer,
  }) {
    return ActiveModel(
        note: note ?? this.note,
        code: code ?? this.code,
        modelId: modelId ?? this.modelId,
        serial: serial ?? this.serial,
        dayBuy: dayBuy ?? this.dayBuy,
        customerId: customerId ?? this.customerId,
        repairingCityId: repairingCityId ?? this.repairingCityId,
        repairingDistrictId: repairingDistrictId ?? this.repairingDistrictId,
        repairingWardId: repairingWardId ?? this.repairingWardId,
        repairingAddressFull: repairingAddressFull ?? this.repairingAddressFull,
        repairingStreet: repairingStreet ?? this.repairingStreet,
        phoneActive: phoneActive ?? this.phoneActive,
        image: image ?? this.image,
        customer: customer ?? this.customer);
  }

  ActiveModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    code = json['code'];
    modelId = json['modelId'];
    serial = json['serial'];
    dayBuy = json['dayBuy'];
    customerId = json['customerId'];
    repairingCityId = json['repairingCityId'];
    repairingDistrictId = json['repairingDistrictId'];
    repairingWardId = json['repairingWardId'];
    repairingAddressFull = json['repairingAddressFull'];
    repairingStreet = json['repairingStreet'];
    phoneActive = json['phoneActive'];
    image = json['image1'];
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['code'] = this.code;
    data['modelId'] = this.modelId;
    data['serial'] = this.serial;
    data['dayBuy'] = this.dayBuy;
    data['customerId'] = this.customerId ?? 0;
    data['repairingCityId'] = this.repairingCityId;
    data['repairingDistrictId'] = this.repairingDistrictId;
    data['repairingWardId'] = this.repairingWardId;
    data['repairingAddressFull'] = this.repairingAddressFull;
    data['repairingStreet'] = this.repairingStreet;
    data['phoneActive'] = this.phoneActive;
    data['image1'] = this.image;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}
