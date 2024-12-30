import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/utils/utils.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoStaffActivate extends StatelessWidget {
  const InfoStaffActivate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText().textSize20(
        title: 'Thông tin kích hoạt viên',
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(
        paddingVer: 15,
        paddingHoz: 10,
        controller: TextEditingController(text: BlocProvider.of<AccountCubit>(context).infoUserModel.staff!.fullName),
        typeInput: TypeInput.text,
        labelText: 'Họ tên',
        readOnly: true,
      ),
      CustomTextField(
        paddingVer: 10,
        paddingHoz: 10,
        controller: TextEditingController(text: Utils().convertDate(DateTime.now())),
        typeInput: TypeInput.text,
        labelText: 'Ngày kích hoạt',
        readOnly: true,
      ),
    ]);
  }
}
