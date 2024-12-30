import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';

class Common {
  static showSnackBar(BuildContext context, String message, {int durationMs = 2500}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message, style: const TextStyle(color: AppColors.white)),
          duration: Duration(milliseconds: durationMs),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))));
  }
}
