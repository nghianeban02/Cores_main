import 'package:dio/dio.dart';

import '../service/api.dart';

class ProductRepository {
  Dio dio = Dio();
  Future<Response> listCategory() async {
    return await dio.get(Api.convertURL(Api.apiListCategory), queryParameters: {"PageSize": 20});
  }

  Future<Response> listModel(int id) async {
    return await dio.get(Api.convertURL(Api.apiListModel), queryParameters: {"PageSize": 20, "IdCategory": id});
  }
}
