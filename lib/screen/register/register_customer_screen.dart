import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/bloc/address/address_cubit.dart';
import 'package:cores_project/service/enum.dart';
import 'package:cores_project/service/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/address_model.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';

class RegisterCustomerScreen extends StatefulWidget {
  const RegisterCustomerScreen({super.key});

  @override
  State<RegisterCustomerScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  final controllerName = TextEditingController();
  final controllerphone = TextEditingController();
  // final controllerCCCD = TextEditingController();
  // final controllerStreet = TextEditingController();
  // final controllerEmail = TextEditingController();

  // final controllerCity = TextEditingController();
  // final controllerDistrist = TextEditingController();
  // final controllerWard = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirm = TextEditingController();
  final key = GlobalKey<FormState>();
  List<ListDataAddress> listCity = [];
  List<ListDataAddress> listDistrist = [];
  List<ListDataAddress> listWard = [];

  late AccountCubit accountCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddressCubit>(context).getListCity();
    accountCubit = BlocProvider.of<AccountCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 500.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          onChanged: (value) {
                            accountCubit.updateFormCustomer(fullName: value);
                          },
                          paddingHoz: 0,
                          controller: controllerName,
                          typeInput: TypeInput.text,
                          labelText: "Họ tên *",
                          validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập họ tên'),
                        ),
                        CustomTextField(
                          onChanged: (value) {
                            accountCubit.updateFormCustomer(phone: value);
                          },
                          paddingHoz: 0,
                          number: true,
                          controller: controllerphone,
                          typeInput: TypeInput.phone,
                          validator: (value) => Validator.checkPhoneNumber(value),
                          labelText: "Số điện thoại *",
                        ),
                        // CustomTextField(
                        //   onChanged: (value) {
                        //     accountCubit.updateFormRegister(mail: value);
                        //   },
                        //   paddingHoz: 0,
                        //   controller: controllerEmail,
                        //   typeInput: TypeInput.email,
                        //   validator: (value) => Validator.validateEmail(value),
                        //   labelText: "Email",
                        // ),
                        CustomTextField(
                          onChanged: (value) {},
                          paddingHoz: 0,
                          controller: controllerPassword,
                          typeInput: TypeInput.password,
                          labelText: "Mật khẩu *",
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
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: BaseButton(
                    width: double.infinity,
                    text: 'Đăng ký',
                    onTap: () {
                      if (key.currentState!.validate()) {
                        accountCubit.sendOpt(controllerphone.text, TypeOTP.KHACHLE, password: controllerPassword.text, name: controllerName.text);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
