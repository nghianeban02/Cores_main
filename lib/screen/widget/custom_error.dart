import 'package:cores_project/navigator/navigator_key.dart';
import 'package:cores_project/utils/utils.dart';
import 'package:cores_project/widget/custom_common.dart';
import 'package:dio/dio.dart';

class CustomDioError {
  static errorDio(DioError e) async {
    if (!Utils.isNullOrEmpty(e.response!.data['errors'])) {
      var list = await e.response!.data['errors'];

      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, (list as Map).values.toList()[0][0].toString());
    } else if (!Utils.isNullOrEmpty(e.response!.data['description'])) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, e.response!.data['description'][0].toString());
    } else if (!Utils.isNullOrEmpty(e.response!.data['detail']) && e.response!.data['detail'].toString().contains('_') == false) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, e.response!.data['detail'].toString());
    } else {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, e.response!.data['title'].toString());
    }
  }
}
