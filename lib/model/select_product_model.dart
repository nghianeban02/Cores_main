// class SelectProductModel {
//   int? value;
//   DataProduct? dataProduct;

//   SelectProductModel({this.value, this.dataProduct});

//   SelectProductModel.fromJson(Map<String, dynamic> json) {
//     value = json['value'];
//     dataProduct = json['data'] != null ? new DataProduct.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['value'] = this.value;
//     if (this.dataProduct != null) {
//       data['data'] = this.dataProduct!.toJson();
//     }
//     return data;
//   }
// }

class SelectProductModel {
  String? code;
  String? name;
  String? note;
  int? value;

  SelectProductModel({this.code, this.name, this.note, this.value});

  SelectProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    note = json['note'];
    value = json['id'];
    name = (json['name'] ?? '').toString().replaceAll('\r\n', '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['note'] = this.note;
    data['id'] = this.value;
    return data;
  }
}
