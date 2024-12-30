import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CustomPagiantion extends StatelessWidget {
  final bool showBack;
  final bool showNext;
  final onPressBack;
  final onPressNext;
  final int limitPage;
  final int currentPage;
  const CustomPagiantion(
      {super.key, this.showBack = true, this.showNext = true, required this.onPressBack, required this.onPressNext, this.limitPage = 1, this.currentPage = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buttonPagination(Icons.arrow_back, onPressBack, showBack),
          CustomText().textSize14(text: 'Trang $currentPage/$limitPage', color: AppColors.black),
          buttonPagination(Icons.arrow_forward, onPressNext, showNext),
        ],
      ),
    );
  }

  buttonPagination(IconData icon, VoidCallback onPress, bool show) {
    return ElevatedButton(
      onPressed: show ? onPress : null,
      child: Icon(
        icon,
        color: show ? AppColors.white : AppColors.grey,
        size: 20,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(side: BorderSide(color: show ? AppColors.grey.withOpacity(0.6) : AppColors.grey.withOpacity(0.2))),
        padding: EdgeInsets.all(7),
        backgroundColor: show ? AppColors.primaryColor : AppColors.white,
        foregroundColor: Colors.grey,
      ),
    );
  }
}
