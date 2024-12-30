import 'package:cores_project/screen_v2/widget/custom_navigation_bar.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {},
        ),
        title: Text(
          'Tin tức',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.br_home),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
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
             
            ],
          ),
        ),
      ),
     // bottomNavigationBar:CustomNavigationBar(),

    );
  }
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

