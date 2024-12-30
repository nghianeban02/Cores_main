import 'package:cores_project/screen_v2/widget/custom_navigation_bar.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountPage(),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        centerTitle: false,
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: SvgPicture.asset(AppAssets.notificationv2),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color:AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const ListTile(
                leading:  CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: AppColors.primaryColor),
                ),
                title:  Text(
                  'Tên tài khoản',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(Icons.calendar_today, 'Hồ sơ khách hàng', () {}),
            _buildMenuItem(Icons.store, 'Cập nhật SHOP', () {}),
            _buildMenuItem(Icons.fingerprint, 'Sinh trắc học', () {}),
            _buildMenuItem(Icons.lock, 'Đổi mật khẩu', () {}),
            _buildMenuItem(Icons.delete, 'Xóa tài khoản', () {}),
            _buildMenuItem(Icons.logout, 'Đăng xuất', () {}),
          ],
        ),
      ),
      
    );

  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color:AppColors.primaryColor),
              const SizedBox(width: 16),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
