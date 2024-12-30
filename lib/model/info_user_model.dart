class InfoUserModel {
  String? account;
  String? idGroupUser;
  String? nameGroupUser;
  String? username;
  Staff? staff;
  String? fullname;

  InfoUserModel({this.account, this.idGroupUser, this.nameGroupUser, this.username, this.staff, this.fullname});

  InfoUserModel.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    idGroupUser = json['idGroupUser'];
    nameGroupUser = json['nameGroupUser'];
    username = json['username'];
    fullname = json['fullName'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['idGroupUser'] = this.idGroupUser;
    data['nameGroupUser'] = this.nameGroupUser;
    data['username'] = this.username;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    return data;
  }
}

class Staff {
  String? staffCreate;

  String? staffUpdate;
  String? updateDate;
  bool? status;
  int? id;
  String? code;
  String? surname;
  String? middleName;
  String? name;
  String? fullName;
  String? mail;
  String? phone;
  String? phone1;
  String? cityName;
  String? districtName;
  String? wardName;
  String? street;
  String? fullAddress;
  String? noIdentity;
  String? idUserCreate;
  Avatar? avatar;

  Staff(
      {this.staffCreate,
      this.staffUpdate,
      this.status,
      this.id,
      this.code,
      this.surname,
      this.middleName,
      this.name,
      this.fullName,
      this.mail,
      this.phone,
      this.phone1,
      this.cityName,
      this.districtName,
      this.wardName,
      this.street,
      this.fullAddress,
      this.noIdentity,
      this.idUserCreate,
      this.updateDate,
      this.avatar});

  Staff.fromJson(Map<String, dynamic> json) {
    staffCreate = json['staffCreate'] ?? '';
    updateDate = json['updateDate'];
    staffUpdate = json['staffUpdate'] ?? '';
    status = json['status'] ?? '';
    id = json['id'];
    code = json['code'] ?? '';
    surname = json['surname'] ?? '';
    middleName = json['middleName'] ?? '';
    name = json['name'] ?? '';
    fullName = json['fullName'] ?? '';
    mail = json['mail'] ?? '';
    phone = json['phone'] ?? '';
    phone1 = json['phone1'] ?? '';
    cityName = json['cityName'] ?? '';
    districtName = json['districtName'] ?? '';
    wardName = json['wardName'] ?? '';
    street = json['street'] ?? '';
    fullAddress = json['fullAddress'] ?? '';
    noIdentity = json['noIdentity'] ?? '';
    idUserCreate = json['idUserCreate'] ?? '';
    avatar = json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffCreate'] = this.staffCreate;
    data['staffUpdate'] = this.staffUpdate;
    data['status'] = this.status;
    data['id'] = this.id;
    data['code'] = this.code;
    data['surname'] = this.surname;
    data['middleName'] = this.middleName;
    data['name'] = this.name;
    data['fullName'] = this.fullName;
    data['mail'] = this.mail;
    data['phone'] = this.phone;
    data['phone1'] = this.phone1;
    data['cityName'] = this.cityName;
    data['districtName'] = this.districtName;
    data['wardName'] = this.wardName;
    data['street'] = this.street;
    data['fullAddress'] = this.fullAddress;
    data['noIdentity'] = this.noIdentity;
    data['idUserCreate'] = this.idUserCreate;
    data['updateDate'] = this.updateDate;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    return data;
  }
}

class Avatar {
  String? value;
  String? original;
  String? thumbnail;

  Avatar({this.value, this.original, this.thumbnail});

  Avatar.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    original = json['original'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['original'] = this.original;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
