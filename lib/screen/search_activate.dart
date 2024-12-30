// import 'package:cores_project/screen/history_activate/list_activate.dart';
// import 'package:cores_project/widget/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/activate/activate_cubit.dart';
// import '../model/list_active_model.dart';
// import '../utils/app_color.dart';
// import '../widget/pagination.dart';

// class SearchActivateScreen extends StatefulWidget {
//   const SearchActivateScreen({super.key});

//   @override
//   State<SearchActivateScreen> createState() => _SearchActivateScreenState();
// }

// class _SearchActivateScreenState extends State<SearchActivateScreen> {
//   late ActivateCubit activateCubit;
//   TextEditingController controller = TextEditingController();
//   int totalPage = 0;
//   int pageIndex = 0;
//   int totalActive = 0;
//   int totalPriceActive = 0;
//   int totalPointActive = 0;
//   List<ListDataActive> listActivate = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     activateCubit = BlocProvider.of<ActivateCubit>(context)..getListActivatePhoneNumber();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus!.unfocus();
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text('Tra cứu kích hoạt'),
//           ),
//           body: Container(
//               color: AppColors.greyLight.withOpacity(0.2),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomTextField(
//                     onChanged: (value) {},
//                     controller: controller,
//                     typeInput: TypeInput.number,
//                     labelText: 'Số điện thoại',
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: () {},
//                     ),
//                   ),
//                   // Row(
//                   //   children: [CustomText().textSize14(text: 'Họ tên :'), CustomText().textSize14(text: "Nguyễn Văn A", color: AppColors.black, fontWeight: FontWeight.w500)],
//                   // ),
//                   // Row(
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //   children: [
//                   //     CustomText().textSize14(text: 'Địa chỉ :'),
//                   //     Expanded(child: CustomText().textSize14(text: "12/12 Nguyễn Căn Cừ, phường 5 , Quận 1, Hồ Chí Minh", color: AppColors.black))
//                   //   ],
//                   // ),
//                   Expanded(
//                       child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: ListActivate(
//                       DOITAC: false,
//                       titles: (fakeData['listData'] as List).map((e) => ListDataActive.fromJson(e)).toList(),
//                     ),
//                   )
//                       // : listActivate.isEmpty && !isLoading
//                       //     ? EmptyDataView()
//                       //     : const Center(child: SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: AppColors.primaryColor))
//                       ),
//                   CustomPagiantion(
//                     onPressNext: () {
//                       activateCubit.getListActivate(indexPage: pageIndex > totalPage ? totalPage : pageIndex + 1);
//                     },
//                     onPressBack: () {
//                       activateCubit.getListActivate(indexPage: pageIndex < 1 ? 1 : pageIndex - 1);
//                     },
//                     currentPage: pageIndex,
//                     limitPage: totalPage,
//                     showBack: pageIndex > 1,
//                     showNext: totalPage > pageIndex,
//                   )
//                 ],
//               ))),
//     );
//   }
// }
