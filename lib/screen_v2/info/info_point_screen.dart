import 'package:cores_project/screen_v2/widget/custom_appbar_screen_v2.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(PointSuccess());
}

class PointSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ActivePointSuccess(),
    );
  }
}

class ActivePointSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      
      appBar: CustomAppBarV2(title: "Thông tin tích điểm"),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.br_home),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 24),
            // Success Icon
            CircleAvatar(
              radius: 36,
              backgroundColor: Colors.green[100],
              child: SvgPicture.asset(
                AppAssets.check,
                height: 48,
              )
            ),
            SizedBox(height: 16),
            // Success Text
           const Text(
              'SẢN PHẨM ĐÃ KÍCH HOẠT',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          const  SizedBox(height: 8),
           const Text(
              'Thông tin sản phẩm đã kích hoạt thành công',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
           const SizedBox(height: 24),
            // Card with Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Tên sản phẩm', 'TD48-ID02'),
                    _buildInfoRow('Mã serial', 'TD48ID0204062318TUIX'),
                    _buildInfoRow('Ngày tích điểm', '20/07/2024'),
                    Divider(thickness: 1),
                    _buildInfoRow('Điểm BIGSHOP', '1000đ'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build each row in the card
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        const  SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
