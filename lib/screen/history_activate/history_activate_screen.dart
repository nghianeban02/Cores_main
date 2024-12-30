import 'package:cores_project/bloc/activate/activate_cubit.dart';
import 'package:cores_project/model/list_active_model.dart';
import 'package:cores_project/screen/history_activate/form_activate.dart';
import 'package:cores_project/screen/history_activate/list_activate.dart';
import 'package:cores_project/service/enum.dart';
import 'package:cores_project/service/validator.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:cores_project/utils/utils.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:cores_project/widget/empty_data.dart';
import 'package:cores_project/widget/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:majascan/majascan.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../bloc/corse/cores_bloc_cubit.dart';

class HistoryActivateScreen extends StatefulWidget {
  const HistoryActivateScreen({super.key});

  @override
  State<HistoryActivateScreen> createState() => _HistoryActivateScreenState();
}

class _HistoryActivateScreenState extends State<HistoryActivateScreen> {
  DateTime selectedDate = DateTime.now().add(Duration(days: 0));
  var searchHistory = SearchHistory.phone.obs;
  final controllerFromDay = TextEditingController();
  final controllerSearch = TextEditingController();
  final controllerSerial = TextEditingController();
  DateTime? pickedFrom;
  final controllerToDay = TextEditingController();
  DateTime? pickedTo;
  bool checkList = true;
  late ActivateCubit activateCubit;
  int totalPage = 0;
  int pageIndex = 0;
  int totalActive = 0;
  int totalPriceActive = 0;
  int totalPointActive = 0;
  List<ListDataActive> listActivate = [];
  String result = "";
  bool DOITAC = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerToDay.text = Utils().convertDate(selectedDate);
    controllerFromDay.text = Utils().convertDate(selectedDate.subtract(Duration(days: 90)));
    activateCubit = BlocProvider.of<ActivateCubit>(context)
      ..getListActivate(
          fromDate: Utils().convertDateSytem(Utils().convertDate(selectedDate.subtract(Duration(days: 90)))),
          toDate: Utils().convertDateSytem(Utils().convertDate(selectedDate.add(Duration(days: 1)))));
    DOITAC = AppPreferencesImpl().getDoiTac == 'DOITAC';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Thống kê kích hoạt'),
          actions: [
            BlocBuilder<CoresBlocCubit, CoresBlocState>(
              builder: (context, state) {
                if (state is CoresOnchangeList) {
                  checkList = state.typeList;
                }
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<CoresBlocCubit>(context).onChangeList(!checkList);
                    },
                    icon: Icon(!checkList ? Icons.list : Icons.grid_view));
              },
            )
          ],
        ),
        body: Container(
          color: AppColors.greyLight.withOpacity(0.2),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Row(
                    children: [
                      CustomText().textSize14(text: 'Tra cứu theo :', color: AppColors.black),
                      ListTile(
                        horizontalTitleGap: 1,
                        minLeadingWidth: 5,
                        contentPadding: EdgeInsets.all(0),
                        title: const Text(
                          'Số điện thoại',
                          style: TextStyle(fontSize: 13),
                        ),
                        leading: Radio<SearchHistory>(
                          value: SearchHistory.phone,
                          groupValue: searchHistory.value,
                          onChanged: (SearchHistory? value) {
                            searchHistory.value = value ?? SearchHistory.phone;
                          },
                        ),
                      ).flexible(),
                      ListTile(
                        horizontalTitleGap: 1,
                        contentPadding: EdgeInsets.all(0),
                        title: const Text(
                          'Serial',
                          style: TextStyle(fontSize: 13),
                        ),
                        leading: Radio<SearchHistory>(
                          value: SearchHistory.serial,
                          groupValue: searchHistory.value,
                          onChanged: (SearchHistory? value) {
                            searchHistory.value = value ?? SearchHistory.serial;
                          },
                        ),
                      ).flexible(),
                    ],
                  ).withHeight(55.h)),
              Obx(() => searchHistory.value == SearchHistory.phone
                  ? Column(
                      children: [
                        Row(
                          children: [
                            pickerDate(
                                lable: 'Từ ngày',
                                controller: controllerFromDay,
                                checkOpen: true,
                                selectableDayPredicate: _decideWhichDayToEnable,
                                day: pickedFrom,
                                isFrom: true,
                                initDate: selectedDate),
                            pickerDate(
                                lable: 'Đến ngày',
                                controller: controllerToDay,
                                checkOpen: pickedFrom != null,
                                selectableDayPredicate: toDaySelect,
                                day: pickedTo,
                                initDate: selectedDate),
                          ],
                        ),
                        Row(
                          children: [
                            CustomTextField(
                              prefixIcon: Icon(Icons.search),
                              controller: controllerSearch,
                              typeInput: TypeInput.number,
                              paddingHoz: 10,
                              hideText: 'Tra cứu theo số điện thoại',
                              // onChanged: (value) {
                              //   activateCubit.getListActivate(
                              //       phone: controllerSearch.text,
                              //       fromDate:
                              //           Utils().convertDateSytem(controllerFromDay.text != '' ? controllerFromDay.text : Utils().convertDate(DateTime.now())),
                              //       toDate: Utils().convertDateSytem(
                              //           controllerToDay.text != '' ? controllerToDay.text : Utils().convertDate(selectedDate.add(Duration(days: 1)))));
                              // },
                            ).flexible(),
                            IconButton(
                                onPressed: () {
                                  activateCubit.getListActivate(
                                      phone: controllerSearch.text,
                                      fromDate:
                                          Utils().convertDateSytem(controllerFromDay.text != '' ? controllerFromDay.text : Utils().convertDate(DateTime.now())),
                                      toDate: Utils().convertDateSytem(
                                          controllerToDay.text != '' ? controllerToDay.text : Utils().convertDate(selectedDate.add(Duration(days: 1)))));
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColors.primaryColor,
                                ))
                          ],
                        ),
                      ],
                    ).paddingBottom(10)
                  : Row(
                      children: [
                        CustomTextField(
                          paddingHoz: 10,
                          onChanged: (value) {
                            activateCubit.updateFormProduct(serial: value);
                          },
                          controller: controllerSerial,
                          typeInput: TypeInput.text,
                          validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập mã sản phẩm'),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              await _scanQRCodeProduct(
                                controllerSerial,
                              );
                              activateCubit.getListActivate(
                                serial: controllerSerial.text,
                              );
                            },
                            child: Icon(Icons.qr_code),
                          ),
                          labelText: 'Số serial',
                        ).flexible(),
                        IconButton(
                            onPressed: () {
                              activateCubit.getListActivate(
                                serial: controllerSerial.text,
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              color: AppColors.primaryColor,
                            ))
                      ],
                    ).paddingBottom(10)),
              Expanded(
                  child: BlocConsumer<ActivateCubit, ActivateState>(
                listener: (context, state) {
                  if (state is GetListActivateSuccess) {
                    listActivate = state.list;
                    pageIndex = state.pageIndex;
                    totalPage = state.totalPage;
                    totalActive = state.totalActive;
                    totalPointActive = state.totalPointActive;
                    totalPriceActive = state.totalPriceActive;
                  }
                },
                builder: (context, state) {
                  bool isLoading = false;

                  if (state is GetListActivateLoading) {
                    isLoading = state.isLoading;
                  }
                  return BlocBuilder<CoresBlocCubit, CoresBlocState>(
                    builder: (context, state) {
                      if (state is CoresOnchangeList) {
                        checkList = state.typeList;
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomText().textSize16(text: 'Tổng phiếu :'),
                                        CustomText().textSize16(text: totalActive.toString(), fontWeight: FontWeight.bold)
                                      ],
                                    ),
                                    SizedBox(
                                      width: 80.w,
                                    ),
                                    Row(
                                      children: [
                                        CustomText().textSize16(text: 'Tổng tích điểm :'),
                                        CustomText().textSize16(text: totalPointActive.toString(), fontWeight: FontWeight.bold)
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomText().textSize16(text: 'Tổng thưởng :'),
                                    CustomText().textSize16(text: Utils.moneyFormat(double.parse(totalPriceActive.toString())), fontWeight: FontWeight.bold)
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: listActivate.isNotEmpty
                                ? checkList
                                    ? ListActivate(
                                        DOITAC: AppPreferencesImpl().getDoiTac == 'DOITAC',
                                        titles: listActivate,
                                      )
                                    : ListFormActivate(
                                        DOITAC: AppPreferencesImpl().getDoiTac == 'DOITAC',
                                        titles: listActivate,
                                      )
                                : listActivate.isEmpty && !isLoading
                                    ? EmptyDataView()
                                    : const Center(child: SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: AppColors.primaryColor))),
                          ),
                          CustomPagiantion(
                            onPressNext: () {
                              activateCubit.getListActivate(indexPage: pageIndex > totalPage ? totalPage : pageIndex + 1);
                            },
                            onPressBack: () {
                              activateCubit.getListActivate(indexPage: pageIndex < 1 ? 1 : pageIndex - 1);
                            },
                            currentPage: pageIndex,
                            limitPage: totalPage,
                            showBack: pageIndex > 1,
                            showNext: totalPage > pageIndex,
                          )
                        ],
                      );
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickerDate(
      {required String lable,
      required TextEditingController controller,
      required bool checkOpen,
      required bool Function(DateTime)? selectableDayPredicate,
      required DateTime? day,
      required DateTime initDate,
      bool isFrom = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            label: Text(lable),
          ),
          onTap: () async {
            if (checkOpen) {
              day = await showDatePicker(
                context: context,
                initialDate: initDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
                selectableDayPredicate: selectableDayPredicate,
              );
              isFrom ? pickedFrom = day : pickedTo = day;
              controller.text = day != null ? Utils().convertDate(day!) : "";
              setState(() {});
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng chọn từ ngày')));
              setState(() {});
            }
          },
        ),
      ),
    );
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }

  bool toDaySelect(DateTime day) {
    if ((day.isBefore(DateTime.now())) && day.isAfter(pickedFrom!.subtract(const Duration(days: 1)))) {
      return true;
    }
    return false;
  }

  _scanQRCodeProduct(TextEditingController controller) async {
    try {
      String? qrResult = await MajaScan.startScan(
          title: "QRcode scanner", titleColor: AppColors.black, qRCornerColor: AppColors.primaryColor, qRScannerColor: AppColors.primaryColor);
      setState(() {
        result = qrResult ?? 'null string';
        controller.text = result;
      });
      return result;
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        result = "Camera permission was denied";
      } else {
        result = "Unknown Error $ex";
      }
    } on FormatException {
      result = "You pressed the back button before scanning anything";
    } catch (ex) {
      result = "Unknown Error $ex";
    }
  }
}
