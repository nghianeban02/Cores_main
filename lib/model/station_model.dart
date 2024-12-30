class StationModel {
  int? id;
  String? name;
  String? phone;
  double? longitude;
  double? latitude;
  String? addressFull;

  StationModel({this.id, this.name, this.phone, this.longitude, this.latitude, this.addressFull});

  StationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    addressFull = json['addressFull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['addressFull'] = this.addressFull;
    return data;
  }
}
