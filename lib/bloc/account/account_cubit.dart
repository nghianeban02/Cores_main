import 'package:bloc/bloc.dart';
import 'package:cores_project/model/info_user_model.dart';
import 'package:cores_project/model/register_model.dart';
import 'package:cores_project/navigator/navigator_key.dart';
import 'package:cores_project/repository/account_repository.dart';
import 'package:cores_project/screen/confirm_otp.dart';
import 'package:cores_project/screen/widget/custom_error.dart';
import 'package:cores_project/service/enum.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigator/app_router.dart';
import '../../widget/custom_common.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  AccountReposipory accountReposipory = AccountReposipory();
  InfoUserModel infoUserModel = InfoUserModel();
  RegisterModel registerModel = RegisterModel();
  RegisterModel registerCustomer = RegisterModel();
  AppPreferencesImpl appPreferencesImpl = AppPreferencesImpl();
  Future login({String password = '', String phoneNumber = ''}) async {
    try {
      emit(LoginLoading(isLoading: true));
      var res = await accountReposipory.login(phoneNumber, password);
      if (res != null && res.data is String) {
        appPreferencesImpl.setToken(res.data);
        appPreferencesImpl.setAccount(phoneNumber);
        appPreferencesImpl.setPassword(password);
        Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.homeScreen, (route) => false);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Đăng nhập thành công');
        emit(LoginLoading(isLoading: false));
      }
    } on DioError catch (e) {
      emit(LoginLoading(isLoading: false));
      CustomDioError.errorDio(e);
    }
  }

  Future changePassword(String oldPass, String newPass) async {
    try {
      var res = await accountReposipory.changePassword(oldPass, newPass);

      if (res != null && res.data != null) {
        Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.homeScreen, (route) => false);
        AppPreferencesImpl().setPassword(newPass);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Đổi mật khẩu thành công');
      }
    } on DioError catch (e) {
      print(e);
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Mật khẩu không hợp lệ');
    }
  }

  Future sendOpt(String phone, TypeOTP typeOTP, {String? password, String? name}) async {
    try {
      var res = await accountReposipory.sendOtp(phone);
      if (res != null && res.statusCode == 200) {
        Navigator.push(
            NavigateKeys().navigationKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => ConfirmOtp(
                      typeOTP: typeOTP,
                      phone: phone,
                      password: password ?? '',
                      name: name ?? "",
                    )));
      }
    } on DioError catch (e) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Số điện thoại không hợp lệ');
    }
  }

  Future checkOtp(String phone, String code) async {
    try {
      var res = await accountReposipory.checkOtp(phone, code);
      if (res != null && res.statusCode == 200) {
        await register();
      }
    } on DioError catch (e) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Mã OTP không đúng');
    }
  }

  Future checkOtpCustomer(
    String password,
    String phone,
    String code,
    String name,
  ) async {
    try {
      var res = await accountReposipory.checkOtp(phone, code);
      if (res != null && res.statusCode == 200) {
        await registerKhachLe(phone, name, password);
        //  await registerKhachLe(phone, name, password);
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future checkOtpFogetPassword(
    String password,
    String phone,
    String code,
  ) async {
    try {
      var res = await accountReposipory.checkOtp(phone, code);
      if (res != null && res.statusCode == 200) {
        await fogetPassword(password, phone);
      }
    } on DioError catch (e) {
      print(e);
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Mã OTP không đúng');
    }
  }

  Future getUserInfo() async {
    try {
      var resUser = await accountReposipory.infoUser();

      if (resUser != null && resUser.data != null) {
        infoUserModel = InfoUserModel.fromJson(resUser.data);
        AppPreferencesImpl().setDoiTac(infoUserModel.idGroupUser);
      }
      emit(GetUserSuccess(infoUserModel: infoUserModel));
    } on DioError catch (e) {
      print(e);
      Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Tài khoản hết hiệu lực');
    }
  }

  Future deleteAccount(BuildContext context) async {
    try {
      var resUser = await accountReposipory.getInfo(infoUserModel.account ?? '');
      if (resUser.statusCode == 200) {
        var resUpdate = await accountReposipory.updateStatusInfo(infoUserModel.account ?? '', resUser.data['updateDate']);
        if (resUpdate.statusCode == 200) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
          AppPreferencesImpl().setToken(null);
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: AppColors.greyLight,
            duration: Duration(seconds: 3),
            messageText: Text('Xóa tài khoản thành công'),
          ));
        } else {
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: AppColors.greyLight,
            duration: Duration(seconds: 3),
            messageText: Text('Vui lòng thử lại sau'),
          ));
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: AppColors.greyLight,
          duration: Duration(seconds: 3),
          messageText: Text('Vui lòng thử lại sau'),
        ));
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future register() async {
    try {
      updateFormRegister(acceptDate: Utils().convertDateToString(DateTime.now()), code: registerModel.phone, noteActive: '');
      var res = await accountReposipory.register(registerModel);
      if (res != null && res.data is String) {
        Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Đăng kí thành công');
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future registerKhachLe(String phone, String name, String password) async {
    try {
      updateFormRegister(acceptDate: Utils().convertDateToString(DateTime.now()), code: registerModel.phone, noteActive: '');
      var res = await accountReposipory.registerKhachLe(phone, name, password);
      if (res != null && res.data is String) {
        Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Đăng kí thành công');
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future fogetPassword(String password, String phone) async {
    try {
      var res = await accountReposipory.fogetPassword(phone, password);
      if (res != null && res.data is String) {
        Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Đổi mật khẩu thành công');
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future updateFormCustomer({String? code, String? fullName, String? mail, String? phone, String? password}) async {
    registerCustomer = registerCustomer.copyWith(code: code, fullName: fullName, mail: mail, phone: phone, password: password);
  }

  Future updateFormRegister({
    String? code,
    String? fullName,
    String? mail,
    String? phone,
    String? street,
    String? noIdentity,
    String? taxCode,
    String? password,
    int? idCity,
    int? idDistrict,
    int? idWard,
    String? fullAddress,
    String? noteActive,
    String? acceptDate,
    String? bankName,
    String? bankAccountName,
    String? bankAccountNumber,
  }) async {
    registerModel = registerModel.copyWith(
        code: code,
        fullName: fullName,
        mail: mail,
        phone: phone,
        street: street,
        taxCode: taxCode,
        noIdentity: noIdentity,
        idCity: idCity,
        idDistrict: idDistrict,
        idWard: idWard,
        password: password,
        fullAddress: fullAddress,
        noteActive: noteActive,
        acceptDate: acceptDate,
        bankName: bankName,
        bankAccountName: bankAccountName,
        bankAccountNumber: bankAccountNumber);
  }
}
