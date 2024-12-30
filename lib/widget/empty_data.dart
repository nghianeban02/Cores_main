import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({Key? key, this.description}) : super(key: key);

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: ((context, index) {
            return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.comments_disabled,
                size: 40,
                color: AppColors.grey,
              ),
              SizedBox(height: 16.w),
              Text(
                description ?? 'Không có dữ liệu',
                style: TextStyle(color: Colors.grey, fontSize: 18.sp),
              ),
            ]);
          })),
    );
    // return SingleChildScrollView(
    //   physics: const AlwaysScrollableScrollPhysics(),
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         SvgPicture.asset(
    //           AppAssets.iconNodata,
    //           width: 40,
    //           height: 40,
    //         ),
    //         const SizedBox(height: 16),
    //         Text(
    //           description ?? 'không có dữ liệu',
    //           style: const TextStyle(color: Colors.grey, fontSize: 18),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
