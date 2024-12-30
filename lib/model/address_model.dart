class AddressModel {
  int? pageIndex;
  int? pageSize;
  int? totalPages;
  int? totalData;
  List<ListDataAddress>? listData;

  AddressModel({this.pageIndex, this.pageSize, this.totalPages, this.totalData, this.listData});

  AddressModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    totalData = json['totalData'];
    if (json['listData'] != null) {
      listData = <ListDataAddress>[];
      json['listData'].forEach((v) {
        listData!.add(new ListDataAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalPages'] = this.totalPages;
    data['totalData'] = this.totalData;
    if (this.listData != null) {
      data['listData'] = this.listData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDataAddress {
  int? id;
  String? code;
  String? name;
  String? keySearch;
  int? status;

  ListDataAddress({this.id, this.code, this.name, this.keySearch, this.status});

  ListDataAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    keySearch = json['keySearch'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['keySearch'] = this.keySearch;
    data['status'] = this.status;
    return data;
  }
}
