import 'package:cores_project/bloc/activate/activate_cubit.dart';
import 'package:cores_project/model/select_product_model.dart';
import 'package:cores_project/navigator/app_router.dart';
import 'package:cores_project/service/launch_url.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class MenuHome extends StatefulWidget {
  bool isDOITAC;
  MenuHome({super.key, required this.isDOITAC});

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  final listIconMenu = [Icons.home, Icons.qr_code, Icons.history, Icons.policy];

  final listTextMenu = [
    'Trang chủ',
    'Kích hoạt bảo hành',
    'Thống kê lịch sử',
    'Chính sách hệ thống',
  ];

  final listTitleMenu = [
    'Trang chủ',
    'Kích hoạt',
    'Thống kê',
    'Chính sách',
  ];

  final listIconMenuKH = [Icons.home, Icons.qr_code, Icons.history];

  final listTextMenuKH = ['Trang chủ', 'Kích hoạt bảo hành', 'Thống kê lịch sử'];

  final listTitleMenuKH = ['Trang chủ', 'Kích hoạt', 'Thống kê'];
  late ActivateCubit activateCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateCubit = BlocProvider.of<ActivateCubit>(context)..getListCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
          itemCount: widget.isDOITAC ? 4 : 3,
          itemBuilder: (BuildContext context, int index) {
            return itemMenuHome(
              context,
              icon: listIconMenu[index],
              text: listTextMenu[index],
              title: listTitleMenu[index],
              index: index,
            );
          }),
    );
  }

  itemMenuHome(
    BuildContext context, {
    required String text,
    required String title,
    required IconData icon,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            // Navigator.pushNamed(context, AppRouter.activateSreen);
            CustomURL().launchURL('https://cores.com.vn/');
            break;
          case 1:
            Navigator.pushNamed(context, AppRouter.activateSreen);
            break;
          case 3:
            showModalBottomSheet(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                context: context,
                builder: (context) {
                  return Container(
                      child: Column(
                    children: [
                      CustomText()
                          .textSize18(title: 'Chính sách theo sản phẩm', color: AppColors.primaryColor, fontWeight: FontWeight.bold)
                          .paddingSymmetric(vertical: 20),
                      Expanded(
                        child: BlocBuilder<ActivateCubit, ActivateState>(
                          builder: (context, value) {
                            return activateCubit.listCategory.isNotEmpty
                                ? ListView.builder(
                                    itemCount: activateCubit.listCategory.length,
                                    itemBuilder: (context, index) {
                                      return itemList(activateCubit.listCategory[index]);
                                    })
                                : Loader();
                          },
                        ),
                      ),
                    ],
                  ));
                });
            // CustomURL().launchURL(
            //     'https://docs.google.com/document/u/0/d/1_GhQjX53sfiXry9tZFN_9yyto49zsrOUVk_xXPvsjbU/mobilebasic?fbclid=IwAR2UrZmWWUXhBZzar0G37AdmvYuj69ktzpbz_gZnb3FIdw1A38kSXpYFuY4');
            break;
          case 2:
            Navigator.pushNamed(context, AppRouter.historyActivateScreen);
            break;
          default:
        }
      },
      child: Container(
        decoration:
            BoxDecoration(color: AppColors.white, border: Border.all(color: AppColors.primaryColor), borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 30,
            ),
            Center(child: CustomText().textSize16(text: title, fontWeight: FontWeight.w600, color: AppColors.primaryColor)),
            CustomText().textSize12(text: text, color: AppColors.primaryColor)
          ],
        ),
      ),
    );
  }

  itemList(SelectProductModel selectProductModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: CustomText().textSize16(text: selectProductModel.name).onTap(() {
        CustomURL().launchURL(selectProductModel.note ?? '');
      }),
    );
  }
}
