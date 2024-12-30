import 'package:cores_project/bloc/activate/activate_cubit.dart';
import 'package:cores_project/model/select_product_model.dart';
import 'package:cores_project/utils/utils.dart';
import 'package:cores_project/service/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majascan/majascan.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/app_color.dart';
import '../../widget/custom_text.dart';

class InfoProduct extends StatefulWidget {
  final bool isCustomer;
  const InfoProduct({super.key, this.isCustomer = false});

  @override
  State<InfoProduct> createState() => _InfoProductState();
}

class _InfoProductState extends State<InfoProduct> {
  final controllerSerial = TextEditingController();
  final controllerCodeActivate = TextEditingController();
  final controllerNameProduct = TextEditingController();
  TextEditingController controllerModelProduct = TextEditingController();
  final controllerDateBuy = TextEditingController();
  String? code;
  String result = "";
  String valueCategory = '';
  String valueModel = '';
  List<SelectProductModel> listCategory = [];
  List<SelectProductModel> listModel = [];
  late ActivateCubit activateCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateCubit = BlocProvider.of<ActivateCubit>(context)..getListCategory();

    controllerModelProduct.text = '';
    controllerNameProduct.text = '';
    activateCubit.resetform();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivateCubit, ActivateState>(builder: (context, state) {
      if (state is AddActivateSuccess) {
        controllerSerial.text = '';
        controllerCodeActivate.text = '';
        controllerModelProduct.text = '';
        controllerNameProduct.text = '';
      }

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomText().textSize20(title: 'Thông tin sản phẩm', color: AppColors.primaryColor, fontWeight: FontWeight.w600),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          onChanged: (value) {
            activateCubit.updateFormProduct(code: controllerCodeActivate.text);
          },
          paddingVer: 5,
          paddingHoz: 10,
          controller: controllerCodeActivate,
          typeInput: TypeInput.text,
          validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập mã kích hoạt'),
          suffixIcon: GestureDetector(
            onTap: () async {
              await _scanQRCodeProduct(controllerCodeActivate);
              activateCubit.updateFormProduct(code: controllerCodeActivate.text);
            },
            child: Icon(Icons.qr_code),
          ),
          labelText: 'Mã kích hoạt *',
        ),
        Row(
          children: [
            CustomTextField(
              paddingHoz: 10,
              onChanged: (value) {
                activateCubit.updateFormProduct(serial: value);
              },
              controller: controllerSerial,
              typeInput: TypeInput.text,
              validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập serial'),
              suffixIcon: GestureDetector(
                onTap: () async {
                  await _scanQRCodeProduct(
                    controllerSerial,
                  );

                  activateCubit.updateFormProduct(serial: controllerSerial.text);
                  activateCubit.getModelbySerial(controllerSerial.text);
                },
                child: Icon(Icons.qr_code),
              ),
              labelText: 'Số serial *',
            ).flexible(),
            Container(
              width: 30,
              child: Icon(Icons.search),
            ).paddingRight(10).onTap(() {
              activateCubit.getModelbySerial(controllerSerial.text);
            })
          ],
        ),
        CustomText().textSize12(text: 'Nhập serial để tra cứu sản phẩm').paddingLeft(10),
        BlocBuilder<ActivateCubit, ActivateState>(builder: (context, state) {
          if (state is GetModelbySerial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controllerModelProduct.text = activateCubit.serialActiveModel.modelName ?? "";
              controllerNameProduct.text = activateCubit.serialActiveModel.categoryName ?? "";
              activateCubit.updateFormProduct(modelId: activateCubit.serialActiveModel.modelId ?? 0);
            });
          }
          return Column(children: [
            CustomTextField(
              paddingHoz: 10,
              readOnly: true,
              controller: controllerNameProduct,
              typeInput: TypeInput.text,
              labelText: 'Sản phẩm *',
            ),
            CustomTextField(
              paddingHoz: 10,
              readOnly: true,
              onChanged: (value) {
                activateCubit.updateFormProduct(serial: value);
              },
              controller: controllerModelProduct,
              typeInput: TypeInput.text,
              labelText: 'Model *',
            ),
          ]);
        }),

        // BlocBuilder<ActivateCubit, ActivateState>(
        //   builder: (context, state) {
        //     if (state is GetCategorySuccess) {
        //       listCategory = state.list;
        //     }
        //     return DropdownProduct(
        //       controller: controllerNameProduct,
        //       labelText: 'Sản phẩm *',
        //       valueSelected: valueCategory,
        //       listData: listCategory,
        //       onChanged: (value) {
        //         controllerModelProduct.text = '';
        //         controllerNameProduct.text = value!.name!;

        //         BlocProvider.of<ActivateCubit>(context).getListModel(value.value!);
        //       },
        //     );
        //   },
        // ),
        // BlocBuilder<ActivateCubit, ActivateState>(
        //   builder: (context, state) {
        //     if (state is GetModelSuccess) {
        //       listModel = state.list;
        //     }
        //     return DropdownProduct(
        //       controller: controllerModelProduct,
        //       labelText: 'Model *',
        //       valueSelected: valueModel,
        //       listData: listModel,
        //       onChanged: (value) {
        //         valueModel = value!.name!;
        //         controllerModelProduct.text = valueModel;
        //         print(value.value);
        //         activateCubit.updateFormProduct(modelId: value.value);
        //       },
        //     );
        //   },
        // ),
        pickerDate(
          lable: 'Ngày Mua *',
          controller: controllerDateBuy,
          checkOpen: true,
          onTap: () async {
            DateTime? day = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
              selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
            );

            controllerDateBuy.text = day != null ? Utils().convertDate(day) : "";
            activateCubit.updateFormProduct(dayBuy: Utils().convertDateSytem(controllerDateBuy.text));
            setState(() {});
          },
        ),
      ]);
    });
  }

  Widget pickerDate({required String lable, required TextEditingController controller, required bool checkOpen, bool isFrom = false, VoidCallback? onTap}) {
    return CustomTextField(
        controller: controller,
        readOnly: true,
        typeInput: TypeInput.text,
        labelText: lable,
        paddingHoz: 10,
        // decoration: InputDecoration(
        //   contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        //   label: Text(lable),
        // ),
        onTap: onTap);
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

  // Future _scanQRCodeActivate() async {
  //   try {
  //     String? qrResult = await MajaScan.startScan(
  //         title: "QRcode scanner", titleColor: AppColors.primaryColor, qRCornerColor: AppColors.primaryColor, qRScannerColor: AppColors.primaryColor);
  //     setState(() {
  //       result = qrResult ?? 'null string';
  //       controllerCodeActivate.text = result;
  //     });
  //   } on PlatformException catch (ex) {
  //     if (ex.code == MajaScan.CameraAccessDenied) {
  //       setState(() {
  //         result = "Camera permission was denied";
  //       });
  //     } else {
  //       setState(() {
  //         result = "Unknown Error $ex";
  //       });
  //     }
  //   } on FormatException {
  //     setState(() {
  //       result = "You pressed the back button before scanning anything";
  //     });
  //   } catch (ex) {
  //     setState(() {
  //       result = "Unknown Error $ex";
  //     });
  //   }
  // }
}
