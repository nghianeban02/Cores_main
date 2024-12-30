import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cores_project/model/address_model.dart';
import 'package:cores_project/repository/address_repository.dart';
import 'package:meta/meta.dart';
import 'package:string_normalizer/string_normalizer.dart';
part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());
  AddressRepository addressRepository = AddressRepository();
  List<ListDataAddress> addressModelCity = [];
  List<ListDataAddress> addressModelDistrist = [];
  List<ListDataAddress> addressModelWard = [];

  Future getListCity({String? search}) async {
    var res = await addressRepository.listCity();
    if (res != null && res != '' && res.data != null) {
      addressModelCity = (res.data['listData'] as List).map((e) => ListDataAddress.fromJson(e)).toList();
      if (search != null && addressModelCity.isNotEmpty) {
        addressModelCity = addressModelCity.where((element) => element.name!.normalize().toLowerCase().contains(search.normalize().toLowerCase())).toList();
        emit(SearchSuccess());
      }
      emit(AddressCitySuccess(listCity: addressModelCity));
    }
  }

  Future getListDistrist(int id, {String? search}) async {
    var res = await addressRepository.listDistrist(id);
    if (res != null && res != '' && res.data != null) {
      addressModelDistrist = (res.data['listData'] as List).map((e) => ListDataAddress.fromJson(e)).toList();
      if (search != null && addressModelDistrist.isNotEmpty) {
        addressModelDistrist =
            addressModelDistrist.where((element) => element.name!.normalize().toLowerCase().contains(search.normalize().toLowerCase())).toList();
        emit(SearchSuccess());
      }
      emit(AddressDistristSuccess(listDistrist: addressModelDistrist));
    }
  }

  Future getListWard(int id, {String? search}) async {
    var res = await addressRepository.listWard(id);
    if (res != null && res != '' && res.data != null) {
      addressModelWard = (res.data['listData'] as List).map((e) => ListDataAddress.fromJson(e)).toList();
      if (search != null && addressModelWard.isNotEmpty) {
        addressModelWard = addressModelWard.where((element) => element.name!.normalize().toLowerCase().contains(search.normalize().toLowerCase())).toList();
        emit(SearchSuccess());
      }
      emit(AddressWardSuccess(listWard: addressModelWard));
    }
  }
}
