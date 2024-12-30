import 'package:cores_project/navigator/app_router.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.br_login_v2), fit: BoxFit.cover)),
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
                        icon: SvgPicture.asset(
                          AppAssets.notificationv2,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRouter.notificationScreen);
                        },
                      )),
                  //  Padding(
                  //   padding: EdgeInsets.only(top: 10.h, left: 40.w, right: 40.w, bottom: 20.h),
                  //   child: Image.asset(
                  //     AppAssets.logo_login,
                  //     height: 60.h,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10.h, left: 40.w, right: 40.w, bottom: 20.h),
                  //   child: Image.asset(
                  //     AppAssets.logo_login,
                  //     height: 60.h,
                  //   ),
                  // ),
                  Image.asset(
                    AppAssets.logo_login,
                    width: 150, // Đặt chiều rộng cụ thể cho logo
                    height: 150,
                  ).paddingSymmetric(horizontal: 20),
                  Image.asset(
                    AppAssets.personal,
                    width: 60, // Đặt chiều rộng cụ thể cho logo
                    height: 60,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const
                   SizedBox(
                    height: 10,
                  ),
                  // Phone Number Input
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15), // Thêm padding 2 bên
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.phone, color: AppColors.primaryColor),
                        hintText: 'Số điện thoại',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

// Password Input
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15), // Thêm padding 2 bên
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            Icon(Icons.lock, color: AppColors.primaryColor),
                        suffixIcon:
                            Icon(Icons.visibility_off, color: Colors.grey),
                        hintText: 'Mật khẩu',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

// Remember Me & Forgot Password
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20), // Thêm padding 2 bên
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {},
                              side: const BorderSide(color: Colors.white),
                            ),
                            const Text(
                              'Ghi nhớ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Quên mật khẩu ?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

// Login Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20), // Thêm padding 2 bên
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 100,
                            ),
                          ),
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SvgPicture.asset(
                          AppAssets.faceid_v2,
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage(AppAssets.user_login_v2)),
                        Text(
                          ' Đăng ký',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(AppAssets.phone),
                        height: 24,
                        width: 24,
                      ),
                      Text(
                        '1800 0079',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
