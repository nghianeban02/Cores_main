import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cores_project/model/serial_active_model.dart';
import 'package:cores_project/navigator/navigator_key.dart';
import 'package:cores_project/repository/activate_repository.dart';
import 'package:cores_project/screen/widget/custom_error.dart';
import 'package:cores_project/service/api.dart';
import 'package:cores_project/widget/custom_common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../model/customer_model.dart';
import '../../model/form_activate_model.dart';
import '../../model/list_active_model.dart';
import '../../model/select_product_model.dart';
import '../../navigator/app_router.dart';
import '../../repository/product_repository.dart';

part 'activate_state.dart';

class ActivateCubit extends Cubit<ActivateState> {
  ActivateCubit() : super(ActivateInitial());
  ActiveModel formActivate = ActiveModel();
  Customer customer = Customer();
  ActiveModel formActivateNotToken = ActiveModel();
  Customer customerNoteToken = Customer();
  ActivateRepository activateRepository = ActivateRepository();
  SerialActiveModel serialActiveModel = SerialActiveModel();
  List<ListDataActive> listActivate = [];
  List<ListDataActive> listActivateSearch = [];
  int pageIndex = 0;
  int totalPage = 0;
  int totalPriceActive = 0;
  int totalPointActive = 0;
  ProductRepository productRepository = ProductRepository();
  List<SelectProductModel> listCategory = [];
  List<SelectProductModel> listModel = [];
  XFile? selectImage;
  resetform() {
    formActivate = ActiveModel();
    customer = Customer();
    selectImage = null;
    formActivateNotToken = ActiveModel();
    customerNoteToken = Customer();
    serialActiveModel = SerialActiveModel();
  }

  updateFormProduct({String? code, String? serial, int? modelId, String? dayBuy, Customer? customer, String? image}) async {
    formActivate = formActivate.copyWith(
      code: code,
      serial: serial,
      dayBuy: dayBuy,
      customer: customer,
      modelId: modelId,
      image: image,
    );
  }

  updateFormCustomer({
    String? fullName,
    String? phone,
    int? cityId,
    int? districtId,
    int? wardId,
    String? street,
    String? wardName,
    String? districtName,
    String? cityName,
    String? addressFull,
  }) async {
    customer = customer.copyWith(
      fullName: fullName,
      phone1: phone,
      cityId: cityId,
      cityName: cityName,
      districtId: districtId,
      districtName: districtName,
      wardId: wardId,
      wardName: wardName,
      street: street,
      addressFull: addressFull,
    );
    formActivate = formActivate.copyWith(
      phoneActive: phone,
    );
  }

  // updateFormProductNoteToken({
  //   String? code,
  //   String? serial,
  //   int? modelId,
  //   String? dayBuy,
  //   Customer? customer,
  // }) async {
  //   formActivateNotToken = formActivateNotToken.copyWith(
  //     code: code,
  //     serial: serial,
  //     dayBuy: dayBuy,
  //     customer: customer,
  //     modelId: modelId,
  //   );
  // }

  // updateFormCustomerNotToken(
  //     {String? fullName,
  //     String? phone,
  //     int? cityId,
  //     int? districtId,
  //     int? wardId,
  //     String? street,
  //     String? wardName,
  //     String? districtName,
  //     String? cityName,
  //     String? image,
  //     String? addressFull}) async {
  //   customerNoteToken = customerNoteToken.copyWith(
  //       fullName: fullName,
  //       phone1: phone,
  //       cityId: cityId,
  //       cityName: cityName,
  //       districtId: districtId,
  //       districtName: districtName,
  //       wardId: wardId,
  //       wardName: wardName,

  //       addressFull: addressFull,
  //       street: street);
  //   formActivateNotToken = formActivateNotToken.copyWith(
  //     phoneActive: phone,
  //     image: image,
  //   );
  // }

  Future getListCategory() async {
    var res = await productRepository.listCategory();
    if (res != null && res != '' && res.data != null) {
      listCategory = (res.data as List).map((e) => SelectProductModel.fromJson(e)).toList();

      emit(GetCategorySuccess(list: listCategory));
    }
  }

  Future getListModel(int id) async {
    var res = await productRepository.listModel(id);

    if (res != null && res != '' && res.data != null) {
      listModel = (res.data['listData'] as List).map((e) => SelectProductModel.fromJson(e['data'])).toList();

      emit(GetModelSuccess(list: listModel));
    }
  }

  Future getListActivate({String? fromDate, String? toDate, int? indexPage, String? phone, String? serial}) async {
    try {
      emit(GetListActivateLoading(isLoading: true));
      var res = await activateRepository.getListActivate(fromDate, toDate, indexPage, phone, serial);
      if (res != null && res != '' && res.data != null) {
        listActivate = (res.data['listData'] as List).map((e) => ListDataActive.fromJson(e)).toList();
        totalPage = res.data['totalPages'];
        pageIndex = res.data['pageIndex'];
        int totalActive = res.data['totalData'];
        var resSum = await activateRepository.sum(fromDate, toDate);
        if (resSum != null && resSum != '' && resSum.data != null) {
          totalPointActive = resSum.data['totalPointActive'];
          totalPriceActive = resSum.data['totalPriceActive'];
        }
        emit(GetListActivateLoading(isLoading: false));
        emit(GetListActivateSuccess(
            list: listActivate,
            totalPage: totalPage,
            pageIndex: pageIndex,
            totalActive: totalActive,
            totalPointActive: totalPointActive,
            totalPriceActive: totalPriceActive));
      }
    } on DioError catch (e) {
      emit(GetListActivateLoading(isLoading: false));
      CustomDioError.errorDio(e);
    }
  }

  Future sum({String? fromDate, String? toDate}) async {
    try {
      emit(GetListActivateLoading(isLoading: true));
    } catch (e) {
      print(e);
      emit(GetListActivateLoading(isLoading: false));
    }
  }

  Future uploadImage() async {
    if (selectImage != null) {
      var res = await activateRepository.uploadImage(File(selectImage!.path));
      if (res != null && res.statusCode == 200) {
        updateFormProduct(image: Api.baseApi + 'file-management/' + res.data['pathOriginal'].toString());
        print(Api.baseApi + 'file-management/' + res.data['pathOriginal'].toString());
      }
    }
  }

  Future getModelbySerial(String serial) async {
    try {
      var res = await activateRepository.getModelbySerial(serial);
      if (res != null && res.data != null) {
        serialActiveModel = SerialActiveModel.fromJson(res.data);
        emit(GetModelbySerial(
            modelId: serialActiveModel.modelId ?? 0,
            modelName: serialActiveModel.modelName ?? '',
            categoryCode: serialActiveModel.categoryCode ?? '',
            categoryId: serialActiveModel.categoryId ?? 0,
            categoryName: serialActiveModel.categoryName ?? ""));
      } else {
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Serial không tồn tại');
        emit(GetModelbySerial(modelId: 0, modelName: '', categoryCode: '', categoryId: 0, categoryName: ""));
      }
    } on DioError catch (e) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Serial không tồn tại');
    }
  }

  Future addActivate() async {
    try {
      emit(AddActivateLoading(isLoading: true));
      uploadImage();
      if (formActivate.dayBuy == null) Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn ngày mua');
      if (customer.cityId != null || customer.districtId != null || customer.wardId != null) {
        updateFormCustomer(addressFull: ' ${customer.street!}, ${customer.wardName!}, ${customer.districtName!}, ${customer.cityName!}');
        updateFormProduct(customer: customer);

        if (formActivate.modelId != null && formActivate.modelId != 0) {
          var res = await activateRepository.addActivate(formActivate);

          if (res != null && res.statusCode == 200) {
            Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.homeScreen, (route) => false);
            resetform();
            Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Kích hoạt thành công');
            emit(AddActivateLoading(isLoading: false));
          }
        } else {
          emit(AddActivateLoading(isLoading: false));
          Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn sản phẩm');
        }
      } else {
        emit(AddActivateLoading(isLoading: false));
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn địa chỉ');
      }
      emit(AddActivateLoading(isLoading: false));
    } on DioError catch (e) {
      emit(AddActivateLoading(isLoading: false));
      CustomDioError.errorDio(e);
    }
  }

  // Future addActivateNotToken() async {
  //   try {
  //     emit(AddActivateLoading(isLoading: true));

  //     print(customerNoteToken.cityId);
  //     if (formActivateNotToken.dayBuy == null) Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn ngày mua');
  //     if (customerNoteToken.cityId != null || customerNoteToken.districtId != null || customerNoteToken.wardId != null) {
  //       updateFormCustomerNotToken(addressFull: '${customerNoteToken.street!}, ${customerNoteToken.wardName}, ${customerNoteToken.districtName!}, ${customerNoteToken.cityName!}');

  //       updateFormProductNoteToken(customer: customerNoteToken);
  //       if (formActivateNotToken.modelId != null) {
  //         var res = await activateRepository.addActivateNotToken(formActivateNotToken);
  //         if (res != null && res.statusCode == 200) {
  //           Navigator.push(NavigateKeys().navigationKey.currentContext!, MaterialPageRoute(builder: (context) => ConfirmOtp(typeOTP: Type,)));

  //           emit(AddActivateLoading(isLoading: false));
  //         }
  //       } else {
  //         emit(AddActivateLoading(isLoading: false));
  //         Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn sản phẩm');
  //       }
  //     } else {
  //       emit(AddActivateLoading(isLoading: false));
  //       Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn địa chỉ');
  //     }
  //     emit(AddActivateLoading(isLoading: false));
  //   } catch (e) {
  //     print(e);
  //     emit(AddActivateLoading(isLoading: false));
  //     Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Sai thông tin kích hoạt');
  //   }
  // }

  // Future getListActivatePhoneNumber({String? phoneNumber, int? indexPage}) async {
  //   listActivateSearch = (fakeData['listData'] as List).map((e) => ListDataActive.fromJson(e)).toList();
  // }
}
