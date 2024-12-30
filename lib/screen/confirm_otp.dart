import 'dart:async';

import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/service/enum.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_button.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

// ignore: must_be_immutable
class ConfirmOtp extends StatefulWidget {
  final String? phone;
  TypeOTP typeOTP;
  String? password;
  String? name;
  ConfirmOtp({super.key, required this.typeOTP, required this.phone, this.password, this.name});

  @override
  State<ConfirmOtp> createState() => _ConfirmOtpState();
}

class _ConfirmOtpState extends State<ConfirmOtp> {
  String code = '';

  final time = '00:00'.obs;
  int remainingSeconds = 1;
  late AccountCubit accountCubit;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountCubit = BlocProvider.of<AccountCubit>(context);
    startTimer(180);
  }

  stopTimer(Timer timer) {
    try {
      timer.cancel();
    } catch (_) {}
  }

  startTimer(int seconds, {VoidCallback? callback}) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    return Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds < 0) {
        timer.cancel();
        if (callback != null) callback.call();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText().textSize24(title: 'Xác nhận OTP', fontWeight: FontWeight.bold),
                SizedBox(
                  height: 30,
                ),
                CustomText().textSize16(text: 'Chúng tôi đã gửi bạn mã code đến số điện thoại ${widget.phone}', textAlign: TextAlign.center),
                CustomText().textSize16(text: 'Vui lòng nhập mã OTP vào ô bên dưới', paddingVer: 20),
                SizedBox(
                  height: 20,
                ),
                OTPTextField(
                  controller: OtpFieldController(),
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  // onCompleted: (pin) {
                  //   accountCubit.checkOtp(accountCubit.registerModel.phone.toString(), pin);
                  // },
                  onChanged: (value) {
                    code = value;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText().textSize14(text: ' Bạn không nhận được mã OTP ?'),
                        time.value != '00:00'
                            ? CustomText().textSize18(title: time.value.toString(), color: AppColors.primaryColor, fontWeight: FontWeight.w600)
                            : TextButton(
                                onPressed: () {
                                  startTimer(180);
                                  accountCubit.sendOpt(widget.phone ?? "", widget.typeOTP);
                                },
                                child: Text('Gửi lại'))
                      ],
                    ))
              ],
            ),
            BaseButton(
              text: 'Xác nhận',
              onTap: () {
                if (widget.typeOTP == TypeOTP.DOITAC) {
                  accountCubit.checkOtp(widget.phone ?? '', code);
                }
                if (widget.typeOTP == TypeOTP.QUENMATKHAU) {
                  accountCubit.checkOtpFogetPassword(widget.password ?? '', widget.phone ?? '', code);
                }
                if (widget.typeOTP == TypeOTP.KHACHLE) {
                  accountCubit.checkOtpCustomer(widget.password ?? '', widget.phone ?? '', code, widget.name ?? '');
                }
              },
              width: 250.w,
            )
          ],
        ),
      ),
    );
  }
}
