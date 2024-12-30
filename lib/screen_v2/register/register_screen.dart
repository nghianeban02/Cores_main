import 'package:cores_project/navigator/app_router.dart';
import 'package:cores_project/screen_v2/login/login_screen.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  _buildTextField("Số điện thoại*"),
                  _buildTextField("Họ tên*"),
                  _buildTextField("Email*"),
                  _buildTextField("CCCD*"),
                  _buildPasswordField("Mật khẩu*"),
                  _buildPasswordField("Xác nhận mật khẩu*"),

                  SizedBox(height: 24),

                  // Shop update section
                  const Row(
                    children: [
                      Icon(Icons.store, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Cập nhật SHOP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildTextField("Người đại diện"),
                  _buildTextField("Mã số thuế"),
                  _buildUploadField(
                      "Hình ảnh giấy phép kinh doanh", Icons.camera_alt),
                  _buildUploadField("Hình ảnh shop", Icons.camera_alt),
                  _buildTextField("Địa chỉ kinh doanh"),
                  _buildTextField("STK ngân hàng"),
                  _buildDropdownField("Tên ngân hàng"),

                  const SizedBox(height: 32),

                  // Register button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical:10,
                        horizontal: 130,
                      ),
                    ),
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Back button
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
                        horizontal: 120,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          Icon( Icons.arrow_back, color: Colors.white),
                         Text(
                          'Quay lại',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
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
  Widget _buildUploadField(String hintText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(icon, color: Colors.grey),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // Dropdown field
  Widget _buildDropdownField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: SizedBox(),
          hint: Text(
            hintText,
            style: TextStyle(color: Colors.grey),
          ),
          items: ["Ngân hàng A", "Ngân hàng B", "Ngân hàng C"]
              .map((bank) => DropdownMenuItem(
                    value: bank,
                    child: Text(bank),
                  ))
              .toList(),
          onChanged: (value) {
            // Handle dropdown selection
          },
          style: TextStyle(color: Colors.white),
          dropdownColor: Color(0xFF8B0000),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterScreen(),
  ));
}
