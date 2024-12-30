import 'package:cores_project/navigator/app_router.dart';
import 'package:cores_project/screen_v2/login/login_screen.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgetPassword1 extends StatefulWidget {
  @override
  State<ForgetPassword1> createState() => _ForgetPassword1State();
}

class _ForgetPassword1State extends State<ForgetPassword1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets
                  .br_login_v2), // Replace with your background image asset
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App logo and bell icon
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
                  Image.asset(
                    AppAssets.logo_login, // Replace with your logo asset
                    height: 100,
                    width: 200,
                  ).paddingSymmetric(horizontal: 20),
                  const SizedBox(height: 20),
                  
                  // Form fields
                  _buildPasswordField("Nhập số điện thoại*"),


                  SizedBox(height: 24),

                  // Shop update section
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 130,
                      ),
                    ),
                    child: const Text(
                      'Hoàn tất ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                     ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical:10,
                        horizontal: 60,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          Icon( Icons.arrow_back, color: Colors.white),
                         Text(
                          'Quay lại trang đăng nhập',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ), 
                  // Back button
                ]),
          ),
        ),
      ),
    );
  }

  // Common TextField widget
  Widget _buildTextField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.clear, color: Colors.grey),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // Password field
  Widget _buildPasswordField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
        ),
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  // File upload field
  // Dropdown field
}

void main() {
  runApp(MaterialApp(
    home: ForgetPassword1(),
  ));
}
