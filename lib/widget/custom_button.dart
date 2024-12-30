import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({super.key, required this.text, required this.onTap, this.color, this.width, this.outlineColor, this.textColor});
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? outlineColor;
  final Color? textColor;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? 130.w,
      height: 50,
      color: color ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(side: BorderSide(color: outlineColor ?? AppColors.primaryColor), borderRadius: BorderRadius.all(Radius.circular(20))),
      textColor: textColor ?? AppColors.white,
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
