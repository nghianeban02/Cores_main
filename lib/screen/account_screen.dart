import 'package:cores_project/navigator/app_router.dart';
import 'package:cores_project/screen/login/login_screen.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_button.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_assets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isCheckLogin = true;
  bool isCheckRegister = false;
  Widget screen = LoginScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_active,
                    color: AppColors.primaryColor,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.notificationScreen);
                  },
                )),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100.h, left: 40.w, right: 40.w, bottom: 10),
                  child: Image.asset(
                    AppAssets.logo,
                    height: 100.h,
                  ),
                ),
                SizedBox(
                    width: 150.w,
                    height: 40,
                    child: Divider(
                      thickness: 3,
                      color: AppColors.black,
                    )),
                CustomText().textSize20(title: 'Kích hoạt bảo hành'.toUpperCase(), color: AppColors.black),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20.h, bottom: 20),
                height: 250.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // BaseButton(
                    //     text: 'Đăng nhập khách lẻ',
                    //     onTap: () {
                    //       Navigator.pushNamed(context, AppRouter.activateSreen, arguments: {'isCustomer': true});
                    //     },
                    //     width: 350.w),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: BaseButton(
                          text: 'Đăng nhập',
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.loginScreen);
                          },
                          width: 350.w),
                    ),
                    BaseButton(
                        color: AppColors.white,
                        textColor: AppColors.primaryColor,
                        text: 'Tra cứu kích hoạt',
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   AppRouter.searchActivate,
                          // );
                        },
                        width: 350.w),
                    // BaseButton(text: 'Đăng kí đối tác', onTap: () {}, width: 350.w)
                  ],
                )),
          ],
        ),
      ),
    );
  }

  itemTab(String text, VoidCallback onTap, bool isCheck) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 130.w,
          height: 50.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: isCheck ? AppColors.primaryColor : AppColors.greyLight),
          child: Center(child: CustomText().textSize16(text: text, color: isCheck ? AppColors.white : AppColors.black, fontWeight: FontWeight.w600)),
        ));
  }
}
  // Row(
  //                           children: [
  //                             itemTab('Đăng nhập', () {
  //                               screen = LoginScreen();
  //                               isCheckLogin = true;
  //                               isCheckRegister = false;
  //                               setState(() {});
  //                             }, isCheckLogin),
  //                             itemTab('Đăng kí', () {
  //                               screen = RegisterScreen();
  //                               isCheckLogin = false;
  //                               isCheckRegister = true;
  //                               setState(() {});
  //                             }, isCheckRegister)
  //                           ],
  //                         )