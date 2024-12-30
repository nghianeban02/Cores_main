import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
// Sắp Xếp Object để đồng bộ giữa client và server
  Map<String, dynamic> sortKeyInJson(Map<String, dynamic> json) {
    return Map.fromEntries(json.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  }

  static String moneyFormat(double money) {
    return NumberFormat('###,###.###').format(money);
  }

  String convertStringDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  static void checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [Permission.camera, Permission.storage, Permission.photos].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted && statusStorage == PermissionStatus.granted && statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      //openCameraGallery();
      //_openDialog(context);
    }
    bool isPermanentlyDenied = statusCamera == PermissionStatus.permanentlyDenied ||
        statusStorage == PermissionStatus.permanentlyDenied ||
        statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
      // _showSettingsDialog(context);
    }
  }

  String convertDateSytem(String date) {
    DateTime parseDate = DateFormat('dd/MM/yyyy').parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("yyyy-MM-dd'T'00:00:00+00:00");
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  String convertDateToString(DateTime date) {
    var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    var outputDate = outputFormat.format(date);
    return outputDate.toString();
  }

  String convertDate(DateTime date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(date);
    return outputDate.toString();
  }

  String convertDateTime(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm:ss dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  String convertDateCreate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  static bool isNullOrEmpty(dynamic obj) =>
      obj == '' || obj == null || (((obj is String && obj.toLowerCase() == 'null') || obj is List || obj is Map) && obj.isEmpty);
}
