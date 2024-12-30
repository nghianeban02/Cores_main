class RegisterModel {
  String? code;
  String? fullName;
  String? mail;
  String? phone;
  String? street;
  String? noIdentity;
  int? idCity;
  int? idDistrict;
  int? idWard;
  String? fullAddress;
  String? noteActive;
  String? acceptDate;
  String? password;
  String? taxCode;
  String? bankName;
  String? bankAccountName;
  String? bankAccountNumber;

  RegisterModel(
      {this.code,
      this.fullName,
      this.mail,
      this.phone,
      this.street,
      this.noIdentity,
      this.idCity,
      this.idDistrict,
      this.idWard,
      this.fullAddress,
      this.noteActive,
      this.acceptDate,
      this.taxCode,
      this.password,
      this.bankName,
      this.bankAccountName,
      this.bankAccountNumber});
  RegisterModel copyWith({
    String? code,
    String? fullName,
    String? mail,
    String? phone,
    String? street,
    String? noIdentity,
    int? idCity,
    int? idDistrict,
    String? password,
    int? idWard,
    String? fullAddress,
    String? taxCode,
    String? noteActive,
    String? acceptDate,
    String? bankName,
    String? bankAccountName,
    String? bankAccountNumber,
  }) {
    return RegisterModel(
        code: code ?? this.code,
        fullName: fullName ?? this.fullName,
        mail: mail ?? this.mail,
        phone: phone ?? this.phone,
        street: street ?? this.street,
        noIdentity: noIdentity ?? this.noIdentity,
        idCity: idCity ?? this.idCity,
        idDistrict: idDistrict ?? this.idDistrict,
        idWard: idWard ?? this.idWard,
        fullAddress: fullAddress ?? this.fullAddress,
        noteActive: noteActive ?? this.noteActive,
        acceptDate: acceptDate ?? this.acceptDate,
        password: password ?? this.password,
        taxCode: taxCode ?? this.taxCode,
        bankName: bankName ?? this.bankName,
        bankAccountName: bankAccountName ?? this.bankAccountName,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber);
  }

  RegisterModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    fullName = json['fullName'];
    mail = json['mail'];
    phone = json['phone'];
    street = json['street'];
    noIdentity = json['noIdentity'];
    idCity = json['idCity'];
    idDistrict = json['idDistrict'];
    idWard = json['idWard'];
    fullAddress = json['fullAddress'];
    noteActive = json['noteActive'];
    acceptDate = json['acceptDate'];
    password = json['password'];
    taxCode = json['taxCode'];
    bankName = json['bankName'];
    bankAccountName = json['bankAccountName'];
    bankAccountNumber = json['bankAccountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['fullName'] = fullName;
    data['mail'] = mail;
    data['phone'] = phone;
    data['street'] = street;
    data['noIdentity'] = noIdentity;
    data['idCity'] = idCity;
    data['idDistrict'] = idDistrict;
    data['idWard'] = idWard;
    data['fullAddress'] = fullAddress;
    data['noteActive'] = noteActive;
    data['acceptDate'] = acceptDate;
    data['password'] = password;
    data['taxCode'] = taxCode;

    data['bankName'] = this.bankName;
    data['bankAccountName'] = this.bankAccountName;
    data['bankAccountNumber'] = this.bankAccountNumber;
    return data;
  }
}
