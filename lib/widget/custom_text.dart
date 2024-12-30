import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_color.dart';

enum TypeInput { name, phone, email, idCard, password, confirmPassword, number, text, multiline }

const EMOJI_REGEXP = r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])';
const MAX_LENGTH_CHARACTER = 50;
const String EMAIL_REGEXP =
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";

class CustomText {
  Widget textSize16(
      {String? text,
      Color color = AppColors.black,
      TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.w400,
      double paddingHoz = 2,
      double paddingVer = 2}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHoz, vertical: paddingVer),
      child: Text(
        text!,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        maxLines: 50,
        style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget textSize14(
      {required String? text,
      Color? color = AppColors.hintText,
      TextAlign textAlign = TextAlign.start,
      int maxline = 0,
      FontWeight fontWeight = FontWeight.w400}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        text!,
        textAlign: textAlign,
        maxLines: maxline != 0 ? maxline : 10000,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          height: 1.25,
          fontSize: 14.sp,
          letterSpacing: 1,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Text textSize12({
    required String? text,
    Color? color = AppColors.hintText,
    TextAlign textAlign = TextAlign.justify,
    int maxline = 0,
  }) {
    return Text(
      text!,
      textAlign: textAlign,
      maxLines: maxline != 0 ? maxline : 10000,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        height: 1.25,
        fontSize: 12.sp,
        letterSpacing: 1.1,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget textSize18(
      {String? title, double paddingHorizontal = 0, double paddingVertical = 0, Color color = AppColors.black, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Text(
        title!,
        style: TextStyle(color: color, fontSize: 18.sp, fontWeight: fontWeight),
      ),
    );
  }

  Widget textSize20(
      {String? title, double paddingHorizontal = 0, double paddingVertical = 0, Color color = AppColors.black, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Text(
        title!,
        style: TextStyle(color: color, fontSize: 20.sp, fontWeight: fontWeight),
      ),
    );
  }

  Widget textSize24(
      {String? title, double paddingHorizontal = 0, double paddingVertical = 0, Color color = AppColors.black, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Text(
        title!,
        style: TextStyle(color: color, fontSize: 24.sp, fontWeight: fontWeight),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TypeInput typeInput;
  final String labelText;
  final bool readOnly;
  final double paddingVer;
  final double paddingHoz;
  final double paddingVerContent;
  final double paddingHozContent;

  final FormFieldValidator<String?>? validator;
  final String initVal;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  final bool? obscureText;
  final int maxLine;
  final bool number;
  final Widget? prefixIcon;
  final String hideText;
  final ValueChanged<String>? onChanged;
  final Color colorEnableBoder;
  final Color colorHideText;
  final Color errorColor;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.typeInput,
    this.labelText = '',
    this.maxLine = 1,
    this.initVal = '',
    this.number = false,
    this.colorEnableBoder = AppColors.grey,
    this.readOnly = false,
    this.hideText = '',
    this.paddingHoz = 20,
    this.paddingVer = 10,
    this.colorHideText = AppColors.grey,
    this.paddingHozContent = 10,
    this.paddingVerContent = 10,
    this.validator,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.obscureText,
    this.onChanged,
    this.errorColor = AppColors.error,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = false;

  TextInputType textTypeInput(TypeInput typeInput) {
    switch (typeInput) {
      case TypeInput.name:
        return TextInputType.text;
      case TypeInput.number:
        return TextInputType.number;
      case TypeInput.phone:
        return TextInputType.phone;
      case TypeInput.email:
        return TextInputType.emailAddress;
      case TypeInput.password:
        return TextInputType.visiblePassword;
      case TypeInput.confirmPassword:
        return TextInputType.visiblePassword;
      case TypeInput.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: widget.paddingVer.h, horizontal: widget.paddingHoz),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onChanged,
            maxLines: widget.maxLine,
            cursorColor: Colors.grey.shade700,
            textAlignVertical: TextAlignVertical.center,
            textAlign: widget.textAlign,
            readOnly: widget.readOnly,
            inputFormatters: [
              widget.number ? LengthLimitingTextInputFormatter(15) : LengthLimitingTextInputFormatter(355),
              if (widget.number) ...{FilteringTextInputFormatter.digitsOnly}
            ],
            obscureText:
                widget.obscureText ?? widget.typeInput == TypeInput.password || widget.typeInput == TypeInput.confirmPassword ? !_passwordVisible : false,
            keyboardType: textTypeInput(widget.typeInput),
            style: TextStyle(color: AppColors.black, fontSize: 14.sp),
            controller: widget.controller,
            onTap: widget.onTap,
            decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: widget.paddingVerContent.w, horizontal: widget.paddingHozContent.w),
                errorStyle: TextStyle(color: widget.errorColor, fontSize: 12.sp),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon ??
                    (widget.typeInput == TypeInput.password || widget.typeInput == TypeInput.confirmPassword
                        ? IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: AppColors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          )
                        : null),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  borderSide: BorderSide(color: widget.colorEnableBoder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  borderSide: BorderSide(color: AppColors.darkBlue),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  borderSide: const BorderSide(color: AppColors.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  borderSide: const BorderSide(color: AppColors.error),
                ),
                labelText: widget.labelText == '' ? null : widget.labelText,
                alignLabelWithHint: true,
                hintText: widget.hideText,
                hintStyle: const TextStyle(color: AppColors.grey),
                labelStyle: TextStyle(color: Colors.grey.shade800, fontSize: 14.sp)),
            validator: widget.validator,
          )),
    );
  }
}
