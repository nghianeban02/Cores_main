import 'dart:convert';

import 'package:cores_project/model/register_model.dart';
import 'package:cores_project/service/api.dart';
import 'package:dio/dio.dart';

import '../utils/utils.dart';
import '../storage/app_preferences.dart';

class AccountReposipory {
  Dio dio = Dio();
  Future<Response> login(String phoneNumber, String password) async {
    return await dio.post(Api.convertURL(Api.apiLogin), options: await options(), data: {
      "account": phoneNumber,
      "password": password,
    });
  }

  Future<Response> infoUser() async {
    return await dio.get(
      Api.convertURL(Api.apiInfoUser),
      options: await options(isUseToken: true),
    );
  }

  Future<Response> getInfo(String id) async {
    return await dio.get(
      Api.convertURL(Api.apiGetInfo.replaceAll('{id}', id)),
      options: await options(isUseToken: true),
    );
  }

  Future<Response> updateStatusInfo(String id, String? date) async {
    print(date);
    return await dio.patch(
      Api.convertURL(Api.apiUpdatestatus.replaceAll('{id}', id)),
      data: {"updateDate": date},
      // queryParameters: {'Account ': id},
      options: await options(isUseToken: true),
    );
  }

//0909094236
  Future register(RegisterModel registerModel) async {
    var res = await dio.post(Api.convertURL(Api.apiRegister),
        options: Options(
          headers: {'Accept': 'text/plain', 'Content-Type': 'application/json'},
        ),
        data: jsonEncode(registerModel));
    return res;
  }

  Future registerKhachLe(String phone, String name, String pasaword) async {
    var res = await dio.post(Api.convertURL(Api.apiRegisterKhachle),
        options: Options(
          headers: {'Accept': 'text/plain', 'Content-Type': 'application/json'},
        ),
        data: {"fullName": name, "phone": phone, "password": pasaword});
    return res;
  }

  Future fogetPassword(String phone, String newPassword) async {
    var res = await dio.patch(Api.convertURL(Api.apiForgetPassword),
        options: Options(
          headers: {'Accept': 'text/plain', 'Content-Type': 'application/json'},
        ),
        data: {'phone': phone, 'passwordNew': newPassword});
    return res;
  }

  Future changePassword(String oldPassword, String newPassword) async {
    var res = await dio
        .post(Api.convertURL(Api.apiChangePassword), options: await options(isUseToken: true), data: {"passwordOld": oldPassword, "passwordNew": newPassword});
    return res;
  }

  Future sendOtp(String phone) async {
    var res = await dio.post(Api.convertURL(Api.sendOtp), data: {
      "phone": phone,
    });
    return res;
  }

  Future<Response> checkOtp(String phone, String code) async {
    var res = await dio.post(Api.convertURL(Api.checkOtp), data: {"phone": phone, 'code': code});
    return res;
  }

  Future<Options> options(
      {bool isNotUsedContentType = true,
      String? hashCode,
      String? tokenProtected,
      bool isUseToken = false,
      bool isNotContentType = false,
      Map<String, dynamic>? header,
      String enctype = ''}) async {
    var token = AppPreferencesImpl().getToken.toString();
    var options = Options(
      headers: {
        'Accept': 'application/json',
      },
    );

    if (header != null) {
      header.forEach((key, value) {
        options.headers![key] = value;
      });
    }
    if (!Utils.isNullOrEmpty(enctype)) {
      options.headers!['enctype'] = enctype;
    }
    if (hashCode != null) {
      options.headers!['hash'] = hashCode;
    }
    if (tokenProtected != null) {
      options.headers!['protected_token'] = tokenProtected;
    }

    if (isNotContentType) {
      if (isNotUsedContentType) {
        options.contentType = 'application/json';
      } else {
        options.contentType = "application/x-www-form-urlencoded";
      }
    }
    try {
      if (token.isNotEmpty && isUseToken) {
        options.headers!['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      print(e);
    }
    return options;
  }
}
