import 'package:cached_network_image/cached_network_image.dart';
import 'package:cores_project/service/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/news_model.dart';
import '../../utils/app_color.dart';
import '../../widget/custom_text.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> listNews = [
    NewsModel(
      image: 'https://cores.com.vn/wp-content/uploads/2023/02/BNFB-ded-moi-bua-com-gd-la-1-ki-niem-vui-500x313.jpg',
      title: 'VỆ SINH MẶT KÍNH BẾP TỪ',
      description: 'Vệ sinh dễ dàng, chống mài mòn tốt, chống trầy xước là những ưu điểm',
    ),
    NewsModel(
      image: 'https://cores.com.vn/wp-content/uploads/2023/02/BNFB-ded-moi-bua-com-gd-la-1-ki-niem-vui-500x313.jpg',
      title: 'VỆ SINH MẶT KÍNH BẾP TỪ',
      description: 'Vệ sinh dễ dàng, chống mài mòn tốt, chống trầy xước là những ưu điểm',
    ),
    NewsModel(
      image: 'https://cores.com.vn/wp-content/uploads/2023/02/BNFB-ded-moi-bua-com-gd-la-1-ki-niem-vui-500x313.jpg',
      title: 'VỆ SINH MẶT KÍNH BẾP TỪ',
      description: 'Vệ sinh dễ dàng, chống mài mòn tốt, chống trầy xước là những ưu điểm',
    ),
    NewsModel(
      image: 'https://cores.com.vn/wp-content/uploads/2022/09/may-hut-mui-cores.jpg',
      title: 'MÁY HÚT MÙI THAN HOẠT TÍNH HAY MÁY HÚT MÙI CÓ ỐNG THOÁT KHÍ?',
      description: 'So sánh máy hút mùi than hoạt tính và máy hút mùi có ống khói...',
    ),
    NewsModel(
      image: 'https://cores.com.vn/wp-content/uploads/2023/02/BNFB-ded-moi-bua-com-gd-la-1-ki-niem-vui-500x313.jpg',
      title: 'VỆ SINH MẶT KÍNH BẾP TỪ',
      description: 'Vệ sinh dễ dàng, chống mài mòn tốt, chống trầy xước là những ưu điểm',
    ),
    NewsModel(
      image: 'https://cores.com.vn/wp-content/uploads/2022/09/may-hut-mui-cores.jpg',
      title: 'MÁY HÚT MÙI THAN HOẠT TÍNH HAY MÁY HÚT MÙI CÓ ỐNG THOÁT KHÍ?',
      description: 'So sánh máy hút mùi than hoạt tính và máy hút mùi có ống khói...',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tin tức'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 20),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16).w,
            itemCount: listNews.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                  onTap: () {
                    CustomURL().launchURL('https://cores.com.vn/ve-sinh-mat-kinh-bep-tu.html');
                  },
                  child: index == 0
                      ? ItemListNews0(
                          newsModel: listNews[index],
                        )
                      : ItemListNewsV2(
                          newsModel: listNews[index],
                        ));
            }),
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1,
                height: 30.w,
              );
            },
          ),
        ));
  }
}

Widget customImageNews(NewsModel newsModel, double width) {
  return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
      width: width.w,
      child: AspectRatio(
          aspectRatio: 1.5,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r), // Image border
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: newsModel.image.toString(),
                placeholder: (context, url) => Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColors.white),
              ))));
}

//Item hiển thị đầu tiên
class ItemListNews0 extends StatelessWidget {
  final NewsModel newsModel;

  const ItemListNews0({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      customImageNews(newsModel, double.infinity),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 0).w,
                child: Text(
                  newsModel.title.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.1, letterSpacing: 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: CustomText().textSize12(text: '12/12/2023', maxline: 3),
              ),
              CustomText().textSize14(text: newsModel.description.toString(), maxline: 3),
            ],
          )),
        ],
      ),
    ]);
  }
}

//Item Hiển thị từ vị trí thứ 2
class ItemListNewsV2 extends StatelessWidget {
  final NewsModel newsModel;

  const ItemListNewsV2({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            height: 80.h,
            child: customImageNews(
              newsModel,
              120.w,
            )),
        SizedBox(width: 10.w),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsModel.title.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, color: AppColors.black, height: 1.1, letterSpacing: 0.5, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: CustomText().textSize12(text: '12/12/2023', maxline: 3),
            ),
            CustomText().textSize14(text: newsModel.description.toString(), maxline: 3),
          ],
        )),
      ],
    );
  }
}
