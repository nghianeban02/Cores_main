import 'dart:convert';
import 'dart:io';

import 'package:cores_project/repository/account_repository.dart';
import 'package:cores_project/service/api.dart';
import 'package:cores_project/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../model/form_activate_model.dart';
import '../storage/app_preferences.dart';

class ActivateRepository {
  Dio dio = Dio();
  Future<Response> addActivate(ActiveModel activeModel) async {
    print(jsonEncode(activeModel));
    print(Api.convertURL(Api.apiAddActivate));
    return await dio.post(Api.convertURL(Api.apiAddActivate), options: await AccountReposipory().options(isUseToken: true), data: jsonEncode(activeModel));
  }

  Future<Response> getModelbySerial(String serial) async {
    return await dio.get(
      Api.convertURL(Api.apiModelbySerial + serial),
      options: await AccountReposipory().options(isUseToken: true),
    );
  }

  Future<Response> addActivateNotToken(ActiveModel activeModel) async {
    print(jsonEncode(activeModel));
    return await dio.post(Api.convertURL(Api.apiAddActivateNotToken), data: jsonEncode(activeModel));
  }

  Future<Response> getListActivate(String? fromDate, String? toDate, int? pageIndex, String? phone, String? serial) async {
    return await dio.get(Api.convertURL(Api.apiListActivate),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/plain',
          'Authorization': 'Bearer ${AppPreferencesImpl().getToken.toString()}',
        }),
        queryParameters: {'FromDate': fromDate ?? '', "ToDate": toDate ?? '', 'PageIndex': pageIndex ?? 1, 'KeySearch': phone, 'Serial': serial});
  }

  Future<Response> sum(String? fromDate, String? toDate) async {
    return await dio.get(Api.convertURL(Api.apiSum),
        options: Options(headers: {'Content-Type': 'application/json', 'Accept': 'text/plain', 'Authorization': 'Bearer ${AppPreferencesImpl().getToken.toString()}'}),
        queryParameters: {'FromDate': fromDate ?? '', "ToDate": toDate ?? ''});
  }

  Future<Response> uploadImage(File file) async {
    print(Api.convertURL(Api.apiUploadImage));
    FormData body = FormData.fromMap({'Image': await MultipartFile.fromFile(file.path, contentType: MediaType("image", "jpeg")), 'GroupImage': "SANPHAM"});
    return await dio.post(Api.convertURL(Api.apiUploadImage), options: await options(isUseToken: true), data: body);
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
