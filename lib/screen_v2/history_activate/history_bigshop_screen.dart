import 'package:cores_project/screen_v2/widget/custom_appbar_screen_v2.dart';
import 'package:cores_project/screen_v2/widget/custom_navigation_bar.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HistoryBigShopScreen(),
    );
  }
}

class HistoryBigShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBarV2(title: "Lịch sử BIGSHOP"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            // Date Range Picker
            _buildDateRange(),
            SizedBox(height: 12),
            _buildContext(),

            // Reward Info
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Điểm BIGSHOP",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryColor),
                  ),
                  Text(
                    "1000 đ",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            // Category Table
            _buildCategoryTable(),
            SizedBox(height: 16),
            // Activated Products Section
            _buildActivatedProductsSection(),
          //  CustomNavigationBar()
          ],
        ))
    );
  }

  Widget _buildDateRange() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildDateBox("01/11/2024"),
          ),
          Icon(Icons.arrow_forward, color: Colors.grey),
          Expanded(
            child: _buildDateBox("30/11/2024"),
          ),
        ],
      ),
    );
  }
  Widget _buildContext() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildDateBox("Thiết bị nhà bếp"),
          ),
          Expanded(
            child: _buildDateBox("Gia dụng"),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBox(String date) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        date,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildCategoryTable() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          Divider(),
          _buildTableRow("Thiết bị nhà bếp", 20, "20.000đ"),
          _buildTableRow("Đồ gia dụng", 20, "20.000đ"),
          _buildTableRow("Điện máy", 20, "20.000đ"),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 3,
        child: Text("Ngành hàng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ),
      Expanded(
        flex: 3,
        child: Center(
          child: Text("Số lượng",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text("Tiền thưởng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    ],
  );
}

  Widget _buildTableRow(String category, int quantity, String reward) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(category, style: TextStyle(fontSize: 14)),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Text(quantity.toString(), style: TextStyle(fontSize: 14)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(reward, style: TextStyle(fontSize: 14)),
        ),
      ],
    ),
  );
}
  Widget _buildActivatedProductsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sản phẩm kích hoạt",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Divider(),
          _buildProductRow("TD48-ID02", "20/11/2024", "09:24:20"),
          _buildProductRow("TD48-ID02", "20/11/2024", "09:24:20"),
          _buildProductRow("TD48-ID02", "20/11/2024", "09:24:20"),
        ],
      ),
    );
  }

  Widget _buildProductRow(String id, String date, String time) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(id, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Bếp từ đôi - $date $time",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          Text("Chi tiết",
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ]));
  }
}
