import 'package:cores_project/screen_v2/widget/custom_appbar_screen_v2.dart';
import 'package:cores_project/screen_v2/widget/custom_navigation_bar.dart';
import 'package:cores_project/screen_v2/widget/input_field.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ActivationApp());
}

class ActivationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ActivationScreen(),
    );
  }
}

class ActivationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBarV2(title: "Kích hoạt"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
           const SizedBox(height: 20),
            // Serial Input Field
           const CustomInputField(
              hintText: 'Serial*',
              icon: Icons.qr_code_scanner,
            ),
           const SizedBox(height: 16),
            // Activation Code Input Field
           const CustomInputField(
              hintText: 'Mã kích hoạt*',
              icon: Icons.qr_code_scanner,
            ),
           const SizedBox(height: 16),
            // Purchase Date Input Field
           const CustomInputField(
              hintText: 'Ngày mua*',
              icon: Icons.calendar_today,
            ),
          const  SizedBox(height: 24),
            // Activation Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Kích hoạt',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: CustomNavigationBar(),
    );
  }
}