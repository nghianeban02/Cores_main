import 'package:cores_project/model/address_model.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../model/select_product_model.dart';

class DropdownProduct extends StatelessWidget {
  String? valueSelected;
  final List<SelectProductModel> listData;
  final double width;
  final double height;
  final String labelText;
  final double paddingHoz;
  TextEditingController controller = TextEditingController();
  final ValueChanged<SelectProductModel?>? onChanged;
  DropdownProduct({
    super.key,
    this.valueSelected = '',
    required this.listData,
    required this.onChanged,
    this.height = 50,
    this.labelText = '',
    this.width = double.infinity,
    this.paddingHoz = 10,
    required this.controller,
  });

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHoz, vertical: 10.h),
      child: Center(
          child: TypeAheadFormField(
        hideOnEmpty: true,
        hideOnError: true,
        animationStart: 0,
        animationDuration: Duration.zero,
        textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              filled: true,
              suffixIcon: Icon(Icons.expand_more),
              fillColor: AppColors.white.withOpacity(0.6),
              labelText: labelText,

              labelStyle: const TextStyle(color: AppColors.black),
              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.h),
            )),
        suggestionsBoxDecoration: SuggestionsBoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        suggestionsCallback: (pattern) {
          Iterable<SelectProductModel> list = listData.where((s) {
            return s.name!.toLowerCase().contains(pattern.toLowerCase());
          });
          return list;
        },
        itemBuilder: (context, sone) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Text(sone.name.toString()),
          );
        },
        onSuggestionSelected: onChanged!,
      )
          //                 TextFormField(
          //   controller: controller,
          //   readOnly: false,
          //   onChanged: (value) {},
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: AppColors.white.withOpacity(0.6),
          //     labelText: labelText,
          //     labelStyle: const TextStyle(color: AppColors.black),
          //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          //     contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          //     suffixIcon: DropdownButtonHideUnderline(
          //       child: DropdownButton2(
          //         isExpanded: true,
          //         items: listData
          //             .map((item) => DropdownMenuItem<SelectProductModel>(
          //                   value: item,
          //                   child: Text(
          //                     item.dataProduct!.name!,
          //                     style: const TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.bold,
          //                       color: AppColors.black,
          //                     ),
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                 ))
          //             .toList(),
          //         onChanged: onChanged,
          //         buttonStyleData: ButtonStyleData(
          //           height: height.h,
          //           width: 50,
          //           padding: const EdgeInsets.symmetric(horizontal: 10),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(14),
          //           ),
          //         ),
          //         iconStyleData: const IconStyleData(
          //           icon: Icon(
          //             Icons.expand_more,
          //           ),
          //           iconSize: 14,
          //           iconEnabledColor: AppColors.black,
          //           iconDisabledColor: Colors.grey,
          //         ),
          //         dropdownStyleData: DropdownStyleData(
          //           maxHeight: 300,
          //           width: 330.w,
          //           direction: DropdownDirection.left,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(14),
          //             color: AppColors.greyLight,
          //           ),
          //           elevation: 8,
          //           scrollbarTheme: ScrollbarThemeData(
          //             radius: const Radius.circular(20),
          //             thickness: MaterialStateProperty.all<double>(6),
          //             thumbVisibility: MaterialStateProperty.all<bool>(true),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
