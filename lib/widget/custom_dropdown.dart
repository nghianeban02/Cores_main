import 'package:cores_project/utils/app_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  final String? valueSelected;
  final List<String> listItem;
  final double width;
  final double height;

  final Color? color;
  final ValueChanged<String?>? onChanged;
  CustomDropDown({
    super.key,
    this.valueSelected,
    required this.listItem,
    required this.onChanged,
    this.height = 50,
    this.width = double.infinity,
    this.color,
  });

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Tên sản phẩm',
              labelStyle: TextStyle(color: AppColors.black),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            ),
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      valueSelected!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: listItem
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              //value: valueSelected,
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                height: height.h,
                width: width.w,
                padding: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.expand_more,
                ),
                iconSize: 14,
                iconEnabledColor: AppColors.black,
                iconDisabledColor: Colors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                width: 330.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.greyLight,
                ),
                elevation: 8,
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(20),
                  thickness: MaterialStateProperty.all<double>(6),
                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
