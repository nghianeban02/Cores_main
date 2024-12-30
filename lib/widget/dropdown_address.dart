import 'dart:async';
import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/bloc/activate/activate_cubit.dart';
import 'package:cores_project/bloc/address/address_cubit.dart';
import 'package:cores_project/model/address_model.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DropdownAddress extends StatefulWidget {
  final String labelText;

  final String type;
  final bool isRegister;
  TextEditingController? controller;
  TextEditingController? controllerDistrist;
  TextEditingController? controllerWard;

  DropdownAddress({super.key, this.labelText = '', required this.type, this.controllerDistrist, this.controllerWard, this.controller, this.isRegister = false});

  @override
  State<DropdownAddress> createState() => _DropdownAddressState();
}

class _DropdownAddressState extends State<DropdownAddress> {
  int selectedValue = 0;
  TextEditingController searchController = TextEditingController();
  AddressCubit? addressCubit;
  ActivateCubit? activateCubit;
  AccountCubit? accountCubit;
  List<ListDataAddress> listData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressCubit = BlocProvider.of(context);
    activateCubit = BlocProvider.of(context);
    accountCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomTextField(
      paddingHoz: 10,
      controller: widget.controller!,
      typeInput: TypeInput.phone,
      labelText: widget.labelText,
      readOnly: true,
      onTap: () async {
        if (widget.type == 'tinh') {
          addressCubit!.getListCity();
        } else if (widget.type == 'quan') {
          addressCubit!.getListDistrist(!widget.isRegister ? activateCubit!.customer.cityId!.toInt() : accountCubit!.registerModel.idCity!.toInt());
        } else if (widget.type == 'ward') {
          addressCubit!.getListWard(!widget.isRegister ? activateCubit!.customer.districtId!.toInt() : accountCubit!.registerModel.idDistrict!.toInt());
        }
        Timer(Duration(seconds: 1), () {
          CircularProgressIndicator();
        });
        showBottomSheetAddress(context);
      },
    ));
  }

  showBottomSheetAddress(
    BuildContext context,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 700,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText().textSize18(
                      title: 'Chọn ' + widget.labelText,
                      fontWeight: FontWeight.bold,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close))
                  ],
                ).paddingSymmetric(horizontal: 16),
                CustomTextField(
                  paddingHoz: 15,
                  controller: searchController,
                  typeInput: TypeInput.text,
                  onChanged: (value) async {
                    if (widget.type == 'tinh') {
                      await addressCubit!.getListCity(search: value);
                    } else if (widget.type == 'quan') {
                      await addressCubit!.getListDistrist(!widget.isRegister ? activateCubit!.customer.cityId!.toInt() : accountCubit!.registerModel.idCity!.toInt(),
                          search: searchController.text);
                    } else if (widget.type == 'ward') {
                      await addressCubit!.getListWard(!widget.isRegister ? activateCubit!.customer.districtId!.toInt() : accountCubit!.registerModel.idDistrict!.toInt(),
                          search: searchController.text);
                    }
                    setState(() {});
                  },
                  prefixIcon: Icon(Icons.search),
                ),
                Expanded(
                    child: BlocBuilder<AddressCubit, AddressState>(
                        buildWhen: (previous, current) =>
                            current is SearchSuccess || current is AddressDistristSuccess || current is AddressWardSuccess || current is AddressCitySuccess,
                        builder: (context, state) {
                          if (state is AddressCitySuccess) {
                            listData = state.listCity;
                          }
                          if (state is AddressDistristSuccess) {
                            listData = state.listDistrist;
                          }
                          if (state is AddressWardSuccess) {
                            listData = state.listWard;
                          }
                          return ListView.builder(
                              itemCount: listData.length,
                              itemBuilder: (context, index) {
                                if (widget.type == 'tinh') {
                                  return itemList(listData[index].name!, () async {
                                    widget.controller!.text = listData[index].name ?? "";
                                    widget.controllerWard!.text = '';
                                    widget.controllerDistrist!.text = '';
                                    addressCubit!.getListDistrist(listData[index].id!.toInt());
                                    widget.isRegister
                                        ? accountCubit!.updateFormRegister(idCity: listData[index].id!.toInt(), idDistrict: null, idWard: null)
                                        : activateCubit!.updateFormCustomer(
                                            cityId: listData[index].id, cityName: listData[index].name, districtId: null, districtName: null, wardId: null, wardName: null);
                                    Get.back();
                                  });
                                } else if (widget.type == 'quan') {
                                  return itemList(listData[index].name!, () async {
                                    widget.controller!.text = listData[index].name ?? "";
                                    widget.controllerWard!.text = '';
                                    addressCubit!.getListWard(listData[index].id!.toInt());
                                    widget.isRegister
                                        ? accountCubit!.updateFormRegister(idDistrict: listData[index].id!.toInt(), idWard: null)
                                        : activateCubit!.updateFormCustomer(districtId: listData[index].id, districtName: listData[index].name, wardId: null, wardName: null);
                                    Get.back();
                                  });
                                } else if (widget.type == 'ward') {
                                  return itemList(listData[index].name!, () async {
                                    widget.controller!.text = listData[index].name ?? "";
                                    widget.isRegister
                                        ? accountCubit!.updateFormRegister(idWard: listData[index].id!.toInt())
                                        : activateCubit!.updateFormCustomer(wardId: listData[index].id, wardName: listData[index].name);
                                    Get.back();
                                  });
                                }
                              });
                        }).paddingAll(10))
              ],
            ).paddingOnly(top: 20),
          ).onTap(() {
            hideKeyboard(context);
          });
        });
  }

  itemList(String text, Function onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText()
            .textSize16(
              text: text,
            )
            .paddingAll(10),
        Divider()
      ],
    ).onTap(onTap);
  }
}
