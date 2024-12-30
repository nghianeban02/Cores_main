import 'package:cores_project/navigator/app_router.dart';
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
      home: WarrantyActivationScreen(),
    );
  }
}

class WarrantyActivationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Kích hoạt bảo hành",
          style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.notificationv2,
            ),
            onPressed: () {
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Account Section
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 32, color: Colors.grey),
                ),
                SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên tài khoản",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tiền thưởng"),
                          Text(
                            "10000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // Table Section
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Table(
                  border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey.shade300)),
                  children: [
                    _buildTableRow("Thiết bị nhà bếp", "20", "20.000"),
                    _buildTableRow("Đồ gia dụng", "20", "20.000"),
                    _buildTableRow("Điện máy", "20", "20.000"),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Activation History Button
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Text(
                "Lịch sử kích hoạt",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          SizedBox(height: 16),

          // Warranty Policies Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCustomButton("Chính sách\nBảo hành"),
              _buildCustomButton("Chính sách\nKích hoạt"),
              _buildCustomButton("Trạm\nBảo hành"),
            ],
          ),

          SizedBox(height: 32),

          // Center QR Button
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.qr_code_scanner,
                      color: Colors.white, size: 36),
                ),
                SizedBox(height: 8),
                Text(
                  "Kích hoạt",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
     // bottomNavigationBar: CustomNavigationBar(),
    );
  }

  TableRow _buildTableRow(String title, String quantity, String price) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.all(12),
        child: Text(title),
      ),
      Padding(
        padding: EdgeInsets.all(12),
        child: Text(quantity, textAlign: TextAlign.center),
      ),
      Padding(
        padding: EdgeInsets.all(12),
        child: Text(price, textAlign: TextAlign.right),
      ),
    ]);
  }

  Widget _buildCustomButton(String title) {
    return SizedBox(
      width: 100,
      height: 70,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }
}
