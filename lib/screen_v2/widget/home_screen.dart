import 'package:cores_project/screen_v2/widget/custom_navigation_bar.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.br_home),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25), 
                child: const  Align(
                  alignment: Alignment.centerLeft,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                       Text(
                        'Xin chào,',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor
                        ),
                      ),
                      Text(
                        'Tên tài khoản',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Icon Grid
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 18.0), // Thêm khoảng cách 2 bên lề
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _iconCard(SvgPicture.asset(AppAssets.website), 'Website',
                          Colors.red),
                      _iconCard(SvgPicture.asset(AppAssets.headphone),
                          'Dịch vụ CSKH', Colors.grey),
                      _iconCard(SvgPicture.asset(AppAssets.question),
                          'Câu hỏi & HDSD', Colors.green)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bigButton('Kích hoạt bảo hành'),
                    _bigButton('BIGSHOP'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // List of Articles
              _newsCard(
                image: AssetImage(AppAssets.kitchen),
                title: 'Những điều cần biết trước khi mua máy hút mùi',
                category: 'Kinh nghiệm',
                date: '04/10',
              ),
              _newsCard(
                image: AssetImage(AppAssets.vietnam),
                title: 'Thông báo nghỉ lễ Quốc Khánh 02/09/2024',
                category: 'Thông báo',
                date: '04/10',
                showFlag: true,
              ),
              _newsCard(
                image: AssetImage(AppAssets.yoga),
                title: 'Mẹo giảm căng thẳng stress cực kì đơn giản',
                category: 'Mẹo hay',
                date: '04/10',
              ),
              const SizedBox(height: 60),
              // Custom Navigation Bar

            ],
            
          ),
        ),
      
      ),
      bottomNavigationBar: CustomNavigationBar(),
    )
    );
  }

  Widget _iconCard(Widget image, String title, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.1),
          child: ClipOval(
            child: image,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _bigButton(String title) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _newsCard({
    required ImageProvider image,
    required String title,
    required String category,
    required String date,
    bool showFlag = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      category,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Spacer(),
                    Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'Ngày đăng: $date',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}