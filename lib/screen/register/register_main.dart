import 'package:cores_project/bloc/corse/cores_bloc_cubit.dart';
import 'package:cores_project/screen/register/register_customer_screen.dart';
import 'package:cores_project/screen/register/register_screen.dart';
import 'package:cores_project/screen/widget/custom_tabbar.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterMain extends StatefulWidget {
  const RegisterMain({super.key});

  @override
  State<RegisterMain> createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomText().textSize24(title: 'Đăng ký', color: AppColors.primaryColor, paddingVertical: 20, fontWeight: FontWeight.bold),
          Padding(
              padding: EdgeInsets.only(top: 0, left: 30, right: 30),
              child: BlocBuilder<CoresBlocCubit, CoresBlocState>(
                builder: (context, state) {
                  if (state is CoresOnchangeTabRegister) {
                    index = state.index;
                  }
                  return CustomTabBar(
                    tabs: ['Khách hàng', 'Đối tác'],
                    indexValue: index,
                  );
                },
              )),
          Expanded(
            child: BlocBuilder<CoresBlocCubit, CoresBlocState>(
              builder: (context, state) {
                if (state is CoresOnchangeTabRegister) {
                  index = state.index;
                }
                return index == 0 ? RegisterCustomerScreen() : RegisterScreen();
              },
            ),
          )
        ],
      ),
    );
  }
}
