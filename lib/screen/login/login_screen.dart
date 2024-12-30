import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/navigator/app_router.dart';
import 'package:cores_project/screen/forget_password/forget_password_1.dart';
import 'package:cores_project/service/bio_login.dart';
import 'package:cores_project/service/launch_url.dart';
import 'package:cores_project/service/validator.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_common.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controllerPhoneNumber = TextEditingController();
  final controllerPassword = TextEditingController();
  final key = GlobalKey<FormState>();
  bool remember = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remember = AppPreferencesImpl().getRemember ?? false;
    if (remember) {
      controllerPhoneNumber.text = AppPreferencesImpl().getAccount ?? '';
      controllerPassword.text = AppPreferencesImpl().getPassword ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.br_login), fit: BoxFit.cover)),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_active,
                        color: AppColors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.notificationScreen);
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 40.w, right: 40.w, bottom: 20.h),
                  child: Image.asset(
                    AppAssets.logo_login,
                    height: 60.h,
                  ),
                ),
                Image.asset(
                  AppAssets.adv_login,
                  width: double.infinity,
                ).paddingSymmetric(horizontal: 20),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: key,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 35, right: 20, bottom: 20),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), border: Border.all(color: AppColors.greyLight, width: 0.5)),
                        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20, bottom: 10),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          CustomTextField(
                            errorColor: AppColors.greyLight,
                            prefixIcon: Icon(Icons.phone),
                            number: true,
                            paddingHoz: 0,
                            controller: controllerPhoneNumber,
                            typeInput: TypeInput.phone,
                            validator: (value) => Validator.checkPhoneNumber(value),
                            hideText: "Số điện thoại",
                          ),
                          CustomTextField(
                            errorColor: AppColors.greyLight,
                            prefixIcon: Icon(Icons.lock),
                            paddingHoz: 0,
                            controller: controllerPassword,
                            typeInput: TypeInput.password,
                            validator: (value) => Validator.checkPassword(value),
                            hideText: "Mật khẩu",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.grey,
                                      ),
                                      child: Checkbox(
                                          activeColor: AppColors.green,
                                          value: remember,
                                          onChanged: (value) {
                                            remember = value ?? false;
                                            AppPreferencesImpl().setRemember(remember);
                                            setState(() {});
                                          })),
                                  CustomText().textSize16(text: 'Ghi nhớ', color: AppColors.greyLight)
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword1()));
                                  },
                                  child: CustomText().textSize16(text: 'Quên mật khẩu', color: AppColors.greyLight)),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: BlocBuilder<AccountCubit, AccountState>(
                                    builder: (context, state) {
                                      if (state is LoginLoading) {
                                        if (state.isLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.white,
                                            ),
                                          );
                                        }
                                      }
                                      return GestureDetector(
                                          onTap: () {
                                            if (key.currentState!.validate()) {
                                              BlocProvider.of<AccountCubit>(context)
                                                  .login(password: controllerPassword.text, phoneNumber: controllerPhoneNumber.text);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.grey, width: 1),
                                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                                image: DecorationImage(image: AssetImage(AppAssets.br_button), fit: BoxFit.fitWidth)),
                                            child: Text(
                                              'Đăng nhập',
                                              style: TextStyle(color: AppColors.white, fontSize: 18, wordSpacing: 2, letterSpacing: 1),
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (AppPreferencesImpl().getBiometric != null) {
                                      if (AppPreferencesImpl().getBiometric == true) {
                                        bool check = await BioLogin.authenticate();
                                        if (check) {
                                          BlocProvider.of<AccountCubit>(context)
                                              .login(password: AppPreferencesImpl().getPassword ?? '', phoneNumber: AppPreferencesImpl().getAccount ?? '');
                                        }
                                      } else {
                                        Common.showSnackBar(context, 'Vui lòng đăng nhập và bật tính năng mở khóa bằng sinh trắc học',
                                            durationMs: 4000);
                                      }
                                    } else {
                                      Common.showSnackBar(context, 'Vui lòng đăng nhập và bật tính năng mở khóa bằng sinh trắc học',
                                          durationMs: 4000);
                                    }
                                  },
                                  child: Container(
                                    //ecoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), border: Border.all(color: AppColors.primaryColor)),
                                    height: 50.h,
                                    width: 50.w,
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset(
                                      Platform.isIOS ? AppAssets.faceId : AppAssets.fingerPrint,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_add,
                                color: AppColors.white,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRouter.registerMain);
                                  },
                                  child: Text(
                                    'Đăng ký',
                                    style: TextStyle(color: AppColors.white, fontSize: 16),
                                  )),
                            ],
                          )
                          // BaseButton(
                          //     color: AppColors.white,
                          //     width: double.infinity,
                          //     textColor: AppColors.primaryColor,
                          //     text: 'Đăng ký khách lẻ',
                          //     onTap: () {
                          //       Navigator.pushNamed(context, AppRouter.registerCustomerScreen);
                          //     }),
                          // SizedBox(height: 16),
                          // BaseButton(
                          //     color: AppColors.white,
                          //     width: double.infinity,
                          //     textColor: AppColors.primaryColor,
                          //     text: 'Đăng ký đối tác',
                          //     onTap: () {
                          //       Navigator.pushNamed(context, AppRouter.registerScreen);
                          //     })
                        ]),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 - 30,
                        top: 5,
                        child: Image.asset(
                          AppAssets.user_login,
                          width: 55,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    CustomURL().launchCaller('18000079');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.phone, color: AppColors.white), CustomText().textSize20(title: '1800 0079', color: AppColors.white)],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
