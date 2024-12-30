import 'package:cores_project/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../model/list_active_model.dart';
import '../../utils/app_color.dart';
import '../../widget/custom_text.dart';

class ListFormActivate extends StatelessWidget {
  ListFormActivate({super.key, required this.titles, required this.DOITAC});
  final List<ListDataActive> titles;
  final bool DOITAC;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return itemListActivate(index, titles[index], index % 2 == 0 ? AppColors.white : AppColors.primaryColor.withOpacity(0.1));
        });
  }

  // ListDataActive(acceptDate: '12/2/2023', code: '123', modelName: 'Bếp từ', serial: 'sdfsdfs', statusActive: 1, priceActive: 122222, pointActive: 12),
  // ListDataActive(acceptDate: '12/2/2023', code: '123', modelName: 'Bếp từ', serial: 'sdfsdfs', statusActive: 1, priceActive: 122222, pointActive: 12),
  // ListDataActive(acceptDate: '12/2/2023', code: '123', modelName: 'Bếp từ', serial: 'sdfsdfs', statusActive: 1, priceActive: 122222, pointActive: 12),
  // ListDataActive(acceptDate: '12/2/2023', code: '123', modelName: 'Bếp từ', serial: 'sdfsdfs', statusActive: 1, priceActive: 122222, pointActive: 12),
  // ListDataActive(acceptDate: '12/2/2023', code: '123', modelName: 'Bếp từ', serial: 'sdfsdfs', statusActive: 0, priceActive: 122222, pointActive: 12),
  // ListDataActive(acceptDate: '12/2/2023', code: '123', modelName: 'Bếp từ', serial: 'sdfsdfs', statusActive: 1, priceActive: 122222, pointActive: 12),
  // ListDataActive(acceptDate: '12/2/2023', code: '123', modelName: 'Bếp từ', serial: 'sdfsdfs', statusActive: 1, priceActive: 122222, pointActive: 12),
  Widget itemListActivate(int index, ListDataActive listDataActive, Color color) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: color),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText().textSize16(text: listDataActive.createDate ?? '', color: AppColors.black, fontWeight: FontWeight.w600),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText().textSize14(text: "Sản phẩm", color: AppColors.primaryColor),
                  CustomText().textSize14(text: "Model", color: AppColors.primaryColor),
                  CustomText().textSize14(text: "Mã kích hoạt", color: AppColors.primaryColor),
                  CustomText().textSize14(text: "Số seri", color: AppColors.primaryColor),
                  if (DOITAC) ...{
                    CustomText().textSize14(text: "Kích hoạt", color: AppColors.primaryColor),
                    CustomText().textSize14(text: "Tích điểm", color: AppColors.primaryColor),
                  }
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText().textSize16(text: listDataActive.category),
                  CustomText().textSize16(text: listDataActive.modelName),
                  CustomText().textSize16(text: listDataActive.code.toString()),
                  CustomText().textSize16(text: listDataActive.serial),
                  if (DOITAC) ...{
                    CustomText().textSize16(text: Utils.moneyFormat(double.parse(listDataActive.priceActive.toString()))),
                    CustomText().textSize16(text: listDataActive.pointActive.toString()),
                  }
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
