import 'package:cores_project/utils/utils.dart';

import 'customer_model.dart';

class ListActiveModel {
  int? pageIndex;
  int? pageSize;
  int? totalPages;
  int? totalData;
  List<ListDataActive>? listDataActive;

  ListActiveModel({this.pageIndex, this.pageSize, this.totalPages, this.totalData, this.listDataActive});

  ListActiveModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'] ?? 0;
    pageSize = json['pageSize'] ?? 0;
    totalPages = json['totalPages'] ?? 0;
    totalData = json['totalData'] ?? 0;
    if (json['ListDataActive'] != null) {
      listDataActive = <ListDataActive>[];
      json['ListDataActive'].forEach((v) {
        listDataActive!.add(new ListDataActive.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalPages'] = totalPages;
    data['totalData'] = totalData;
    if (this.listDataActive != null) {
      data['ListDataActive'] = this.listDataActive!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDataActive {
  String? staffCreate;
  String? createDate;
  String? staffUpdate;
  String? updateDate;
  int? status;
  int? id;
  String? code;
  int? storeId;
  int? acceptBy;
  String? acceptDate;
  String? dayBuy;
  String? note;
  String? serial;
  int? modelId;
  String? modelName;
  int? customerId;
  String? activeDataId;
  String? category;
  int? idUserCreate;

  String? phoneActive;
  int? statusActive;
  String? noteActive;
  int? priceActive;
  int? pointActive;
  Customer? customer;

  ListDataActive(
      {this.staffCreate,
      this.createDate,
      this.staffUpdate,
      this.updateDate,
      this.status,
      this.id,
      this.code,
      this.storeId,
      this.acceptBy,
      this.acceptDate,
      this.dayBuy,
      this.note,
      this.serial,
      this.modelId,
      this.modelName,
      this.customerId,
      this.activeDataId,
      this.idUserCreate,
      this.phoneActive,
      this.statusActive,
      this.noteActive,
      this.priceActive,
      this.pointActive,
      this.category,
      this.customer});

  ListDataActive.fromJson(Map<String, dynamic> json) {
    staffCreate = json['staffCreate'];
    createDate = Utils().convertDateCreate(json['createDate'].toString().split('.')[0]);
    staffUpdate = json['staffUpdate'];
    updateDate = json['updateDate'];
    status = json['status'];
    id = json['id'];
    code = json['code'];
    storeId = json['storeId'];
    acceptBy = json['acceptBy'];
    acceptDate = json['acceptDate'];
    dayBuy = json['dayBuy'];
    note = json['note'];
    serial = json['serial'];
    modelId = json['modelId'];
    modelName = json['modelName'];
    customerId = json['customerId'];
    activeDataId = json['activeDataId'];
    category = (json['categoryName'] ?? '').toString().replaceAll('\r\n', '');
    idUserCreate = json['idUserCreate'];
    phoneActive = json['phoneActive'];
    statusActive = json['statusActive'];
    noteActive = json['noteActive'];
    priceActive = json['priceActive'];
    pointActive = json['pointActive'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['staffCreate'] = staffCreate;
    data['createDate'] = createDate;
    data['staffUpdate'] = staffUpdate;
    data['updateDate'] = updateDate;
    data['status'] = status;
    data['id'] = id;
    data['code'] = code;
    data['storeId'] = storeId;
    data['acceptBy'] = acceptBy;
    data['acceptDate'] = acceptDate;
    data['dayBuy'] = dayBuy;
    data['note'] = note;
    data['serial'] = serial;
    data['modelId'] = modelId;
    data['modelName'] = modelName;
    data['customerId'] = customerId;
    data['activeDataId'] = activeDataId;

    data['idUserCreate'] = idUserCreate;

    data['phoneActive'] = phoneActive;
    data['statusActive'] = statusActive;
    data['noteActive'] = noteActive;
    data['priceActive'] = priceActive;
    data['pointActive'] = pointActive;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }

  String get getStatus => statusActive == 0
      ? 'Chưa kích hoạt'
      : statusActive == 1
          ? 'Đã kích hoạt'
          : 'Đã từ chối';
  String totalPoint(List<ListDataActive> list) {
    var point = list.map((expense) => expense.pointActive).fold(0, (prev, amount) {
      return prev + amount!;
    });
    return point.toString();
  }

  String totalPrice(List<ListDataActive> list) {
    var point = list.map((expense) => expense.priceActive).fold(0, (prev, amount) {
      return prev + amount!;
    });
    return point.toString();
  }
}
