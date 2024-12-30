import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/navigator/app_router.dart';
import 'package:cores_project/service/bio_login.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_button.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../service/launch_url.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late AccountCubit accountCubit;
  bool isBio = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountCubit = BlocProvider.of<AccountCubit>(context)..getUserInfo();
    isBio = AppPreferencesImpl().getBiometric ?? false;
    print('innit' + isBio.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 300.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Color.fromARGB(248, 255, 255, 255), Color.fromARGB(255, 194, 194, 194)]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  AppAssets.logo,
                  height: 130,
                  width: 180,
                ),
                Center(
                    child: CustomText().textSize18(
                  title: AppPreferencesImpl().getDoiTac!.toUpperCase() == 'DOITAC'
                      ? accountCubit.infoUserModel.staff!.fullName
                      : accountCubit.infoUserModel.fullname,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                )),
                Center(child: CustomText().textSize16(text: accountCubit.infoUserModel.username, color: AppColors.primaryColor, fontWeight: FontWeight.w600)),
                Divider(
                  thickness: 1,
                  height: 60,
                ),
                itemMenu(
                    icon: Icons.home_outlined,
                    text: "Trang chủ",
                    onTap: () {
                      print('Trang chủ');
                      CustomURL().launchURL('https://cores.com.vn/');
                    }),
                itemMenu(
                    icon: Icons.person_outline,
                    text: "Thông tin cá nhân",
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.userInfo);
                    }),
                itemMenu(
                    icon: Icons.verified_user_outlined,
                    text: "Kích hoạt",
                    onTap: () {
                      print('Kích hoạt');
                      Navigator.pushNamed(context, AppRouter.activateSreen);
                    }),
                itemMenu(
                    icon: Icons.history,
                    text: "Thống kê kích hoạt",
                    onTap: () {
                      print('Thống kê kích hoạt');
                      Navigator.pushNamed(context, AppRouter.historyActivateScreen);
                    }),
                itemMenu(
                    icon: Icons.list,
                    text: "Trạm bảo hành",
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.warrantyStation);
                    }),
                itemMenu(
                    icon: Icons.description_outlined,
                    text: "Thông báo",
                    onTap: () {
                      print('Thông báo,');
                      Navigator.pushNamed(context, AppRouter.notificationScreen);
                    }),
                itemMenu(
                    icon: Icons.manage_accounts_outlined,
                    text: "Đổi mật khẩu",
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.changePasswordScreen);
                    }),
                itemMenu(
                    icon: Icons.delete_forever_outlined,
                    text: "Xóa tài khoản",
                    textColor: AppColors.primaryColor,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                BaseButton(
                                  text: 'Hủy',
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  color: AppColors.white,
                                  textColor: AppColors.primaryColor,
                                ),
                                BaseButton(
                                    text: 'Xóa tài khoản',
                                    onTap: () {
                                      accountCubit.deleteAccount(context);
                                    })
                              ],
                              content: CustomText().textSize14(
                                text: 'Bạn có chắc chắn xóa tài khoản? Sau khi xóa tài khoản sẽ không thể khôi phục',
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Thông báo'),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                            );
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Switch(
                        // This bool value toggles the switch.
                        value: isBio,
                        activeColor: AppColors.primaryColor,
                        onChanged: (bool value) async {
                          // This is called when the user toggles the switch.

                          if (value) {
                            final check = await BioLogin.authenticate();
                            setState(() {
                              if (check) {
                                isBio = value;
                              } else {
                                isBio = false;
                              }
                            });
                          } else {
                            setState(() {
                              isBio = false;
                            });
                          }
                          print(isBio);
                          AppPreferencesImpl().setBiometric(isBio);
                        },
                      ),
                      CustomText().textSize18(title: 'Sử dụng sinh trắc học', color: AppColors.primaryColorBlueDark)
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BaseButton(
                  outlineColor: AppColors.grey,
                  color: AppColors.primaryColor,
                  text: 'Đăng xuất',
                  onTap: () {
                    print('Đăng xuất');
                    Navigator.pushNamedAndRemoveUntil(context, AppRouter.loginScreen, (route) => false);
                    AppPreferencesImpl().setToken(null);
                  }),
            )
          ],
        ),
      ),
    );
  }

  itemMenu({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 25.r,
              color: textColor ?? AppColors.primaryColorBlueDark,
            ),
            SizedBox(
              width: 15,
            ),
            CustomText().textSize18(title: text, color: textColor ?? AppColors.primaryColorBlueDark)
          ],
        ),
      ),
    );
  }
}
