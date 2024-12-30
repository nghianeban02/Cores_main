import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/bloc/address/address_cubit.dart';
import 'package:cores_project/screen/register/info_bank.dart';
import 'package:cores_project/service/enum.dart';
import 'package:cores_project/service/validator.dart';
import 'package:cores_project/widget/custom_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../model/address_model.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/dropdown_address.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controllerName = TextEditingController();
  final controllerphone = TextEditingController();
  final controllerCCCD = TextEditingController();
  final controllerStreet = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllertax = TextEditingController();
  final controllerCity = TextEditingController();
  final controllerDistrist = TextEditingController();
  final controllerWard = TextEditingController();
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
                            accountCubit.updateFormRegister(fullName: value);
                          },
                          paddingHoz: 10,
                          controller: controllerName,
                          typeInput: TypeInput.text,
                          labelText: "Họ tên *",
                          validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập họ tên'),
                        ),
                        CustomTextField(
                          onChanged: (value) {
                            accountCubit.updateFormRegister(phone: value);
                          },
                          paddingHoz: 10,
                          number: true,
                          controller: controllerphone,
                          typeInput: TypeInput.phone,
                          validator: (value) => Validator.checkPhoneNumber(value),
                          labelText: "Số điện thoại *",
                        ),
                        CustomTextField(
                          onChanged: (value) {
                            accountCubit.updateFormRegister(taxCode: value);
                          },
                          paddingHoz: 10,
                          number: true,
                          controller: controllertax,
                          typeInput: TypeInput.number,
                          //  validator: (value) => Validator.checkNull(value),
                          labelText: "Mã số thuế",
                        ),
                        CustomTextField(
                          onChanged: (value) {
                            accountCubit.updateFormRegister(mail: value);
                          },
                          paddingHoz: 10,
                          controller: controllerEmail,
                          typeInput: TypeInput.email,
                          validator: (value) => Validator.validateEmail(value),
                          labelText: "Email *",
                        ),
                        CustomTextField(
                          onChanged: (value) {
                            accountCubit.updateFormRegister(password: value);
                          },
                          paddingHoz: 10,
                          controller: controllerPassword,
                          typeInput: TypeInput.password,
                          labelText: "Mật khẩu *",
                          validator: (value) => Validator.checkPassword(value),
                        ),
                        CustomTextField(
                          paddingHoz: 10,
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
                        DropdownAddress(
                          type: 'tinh',
                          isRegister: true,
                          controller: controllerCity,
                          controllerDistrist: controllerDistrist,
                          controllerWard: controllerWard,
                          labelText: 'Tỉnh/Thành phố *',
                        ),
                        DropdownAddress(
                          type: 'quan',
                          isRegister: true,
                          labelText: 'Quận/Huyện *',
                          controller: controllerDistrist,
                          controllerWard: controllerWard,
                        ),
                        DropdownAddress(
                          type: 'ward',
                          isRegister: true,
                          controller: controllerWard,
                          labelText: 'Phường/Xã *',
                        ),
                        CustomTextField(
                          paddingHoz: 10,
                          controller: controllerStreet,
                          typeInput: TypeInput.text,
                          onChanged: (value) {
                            accountCubit.updateFormRegister(street: value);
                          },
                          validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập địa chỉ'),
                          labelText: "Số nhà, đường *",
                        ),
                        CustomTextField(
                          paddingHoz: 10,
                          controller: controllerCCCD,
                          onChanged: (value) {
                            accountCubit.updateFormRegister(noIdentity: value);
                          },
                          typeInput: TypeInput.number,
                          labelText: "CCCD/CMND",
                        ).paddingBottom(10),
                        InfoBank(),
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
                        print(accountCubit.registerModel.toJson());
                        if (controllerCity.text != '' && controllerDistrist.text != '' && controllerWard.text != '') {
                          accountCubit.updateFormRegister(
                              fullAddress: '${controllerStreet.text}, ${controllerWard.text}, ${controllerDistrist.text}, ${controllerCity.text}');
                          accountCubit.sendOpt(controllerphone.text, TypeOTP.DOITAC);
                          //  Navigator.pushNamed(context, AppRouter.confirmOtp, arguments: {'phone': controllerphone.text, 'isDOITAC': true});
                        } else {
                          Common.showSnackBar(context, 'Vui lòng chọn địa chỉ');
                        }
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
