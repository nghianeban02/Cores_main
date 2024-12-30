import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/service/validator.dart';
import 'package:cores_project/widget/custom_button.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ForgetPassword2 extends StatefulWidget {
  final String phone;
  const ForgetPassword2({super.key, required this.phone});

  @override
  State<ForgetPassword2> createState() => _ForgetPassword2State();
}

class _ForgetPassword2State extends State<ForgetPassword2> {
  final controllerPassword = TextEditingController();
  final controllerConfirm = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Quên mật khẩu'),
          ),
          body: Form(
              key: key,
              child: Column(
                children: [
                  CustomText().textSize18(title: 'Nhập mật khẩu mới', fontWeight: FontWeight.w500).paddingSymmetric(vertical: 20),
                  CustomTextField(
                    onChanged: (value) {},
                    controller: controllerPassword,
                    typeInput: TypeInput.password,
                    prefixIcon: Icon(Icons.lock),
                    hideText: "Mật khẩu mới*",
                    validator: (value) => Validator.checkPassword(value),
                  ),
                  CustomTextField(
                    prefixIcon: Icon(Icons.lock),
                    controller: controllerConfirm,
                    typeInput: TypeInput.confirmPassword,
                    hideText: "Nhập lại mật khẩu *",
                    validator: (value) {
                      if (value != controllerPassword.text) {
                        return 'Mật khẩu chưa chính xác';
                      }
                      return Validator.checkNull(value, messageErrorNull: 'Vui lòng điền mật khẩu xác nhận', maxChar: 50);
                    },
                  ),
                  BaseButton(
                    text: 'Tiếp tục',
                    onTap: () {
                      if (key.currentState!.validate()) {
                        //  BlocProvider.of<AccountCubit>(context).fogetPassword(controllerPassword.text, phoneController.text);
                        BlocProvider.of<AccountCubit>(context).fogetPassword(controllerPassword.text, widget.phone);
                      }
                    },
                    width: double.infinity,
                  ).paddingSymmetric(horizontal: 20, vertical: 20)
                ],
              ).paddingOnly(top: 30)),
        ));
  }
}
