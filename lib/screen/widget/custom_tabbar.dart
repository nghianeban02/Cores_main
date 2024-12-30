import 'package:cores_project/bloc/corse/cores_bloc_cubit.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CustomTabBar extends StatelessWidget {
  final List<String> tabs;

  int indexValue;

  CustomTabBar({required this.tabs, this.indexValue = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.greyLight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<CoresBlocCubit>(context).onChangeTabRegister(index);
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(color: indexValue == index ? AppColors.primaryColor : AppColors.greyLight, borderRadius: BorderRadius.circular(25.0)),
                child: Center(
                    child: CustomText().textSize16(
                  text: tabs[index],
                  fontWeight: FontWeight.w600,
                  color: indexValue == index ? AppColors.white : AppColors.hintText,
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
