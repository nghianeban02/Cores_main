class SerialActiveModel {
  int? id;
  int? modelId;
  String? modelName;
  int? categoryId;
  String? categoryCode;
  String? categoryName;
  int? statusActiveSerial;

  SerialActiveModel({this.id, this.modelId, this.modelName, this.categoryId, this.categoryCode, this.categoryName, this.statusActiveSerial});

  SerialActiveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['modelId'];
    modelName = json['modelName'];
    categoryId = json['categoryId'];
    categoryCode = json['categoryCode'];
    categoryName = json['categoryName'];
    statusActiveSerial = json['statusActiveSerial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modelId'] = this.modelId;
    data['modelName'] = this.modelName;
    data['categoryId'] = this.categoryId;
    data['categoryCode'] = this.categoryCode;
    data['categoryName'] = this.categoryName;
    data['statusActiveSerial'] = this.statusActiveSerial;
    return data;
  }
}
