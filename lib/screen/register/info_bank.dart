import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/service/validator.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/custom_text.dart';

class InfoBank extends StatefulWidget {
  const InfoBank({
    super.key,
  });

  @override
  State<InfoBank> createState() => _InfoBankState();
}

class _InfoBankState extends State<InfoBank> {
  final controllerBankName = TextEditingController();
  final controllerAccountName = TextEditingController();
  final controllerAccountNumber = TextEditingController();

  late AccountCubit accountCubit;
  // final controllerNameProduct = TextEditingController();
  // final controllerDateActivate = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accountCubit = BlocProvider.of<AccountCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText().textSize20(title: 'Thông tin ngân hàng', color: AppColors.primaryColor, fontWeight: FontWeight.w600),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(
        onChanged: (value) {
          accountCubit.updateFormRegister(bankName: value);
        },
        paddingHoz: 10,
        controller: controllerBankName,
        typeInput: TypeInput.text,
        validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập tên ngân hàng'),
        labelText: 'Tên Ngân hàng *',
      ),
      CustomTextField(
        onChanged: (value) {
          accountCubit.updateFormRegister(bankAccountNumber: value);
        },
        paddingVer: 10,
        paddingHoz: 10,
        controller: controllerAccountNumber,
        validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập số tài khoản'),
        typeInput: TypeInput.text,
        labelText: 'Số tài khoản *',
      ),
      CustomTextField(
        onChanged: (value) {
          accountCubit.updateFormRegister(bankAccountName: value);
        },
        paddingVer: 10,
        paddingHoz: 10,
        controller: controllerAccountName,
        validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập tên tài khoản'),
        typeInput: TypeInput.text,
        labelText: 'Tên tài khoản *',
      ),
    ]);
  }
}
