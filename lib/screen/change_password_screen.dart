import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/validator.dart';
import '../widget/custom_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final controllerPassword = TextEditingController();
  final controllerConfirm = TextEditingController();
  final controllerPasswordOld = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi mật khẩu'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: key,
          child: Column(children: [
            CustomTextField(
              paddingHoz: 0,
              controller: controllerPasswordOld,
              typeInput: TypeInput.password,
              labelText: "Mật khẩu cũ *",
              validator: (value) => Validator.checkPassword(value),
            ),
            CustomTextField(
              paddingHoz: 0,
              controller: controllerPassword,
              typeInput: TypeInput.password,
              labelText: "Mật khẩu mới *",
              validator: (value) => Validator.checkPassword(value),
            ),
            CustomTextField(
              paddingHoz: 0,
              controller: controllerConfirm,
              typeInput: TypeInput.confirmPassword,
              labelText: "Nhập lại mật khẩu *",
              validator: (value) {
                if (value != controllerPassword.text) {
                  return 'Mật khẩu chưa chính xác';
                }
                return Validator.checkNull(value, messageErrorNull: 'Vui lòng điền mật khẩu xác nhận', maxChar: 50);
              },
            ),
            SizedBox(height: 30),
            BaseButton(
                text: 'Đổi mật khẩu',
                onTap: () {
                  if (key.currentState!.validate()) {
                    BlocProvider.of<AccountCubit>(context).changePassword(controllerPasswordOld.text, controllerPassword.text);
                  }
                })
          ]),
        ),
      ),
    );
  }
}
