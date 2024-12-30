import 'package:bloc/bloc.dart';
import 'package:cores_project/model/address_model.dart';
import 'package:cores_project/model/station_model.dart';
import 'package:cores_project/repository/address_repository.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:string_normalizer/string_normalizer.dart';

part 'warranty_station_state.dart';

class WarrantyStationCubit extends Cubit<WarrantyStationState> {
  WarrantyStationCubit() : super(WarrantyStationInitial());
  AddressRepository addressRepository = AddressRepository();
  List<ListDataAddress> addressModelCity = [];
  List<StationModel> listStation = [];
  Future getListCity({String? search}) async {
    var res = await addressRepository.listCity();
    if (res != null && res != '' && res.data != null) {
      addressModelCity = (res.data['listData'] as List).map((e) => ListDataAddress.fromJson(e)).toList();
      if (search != null && search != '' && addressModelCity.isNotEmpty) {
        addressModelCity = addressModelCity.where((element) => element.name!.normalize().toLowerCase().contains(search.normalize().toLowerCase())).toList();
      }
    }
    return addressModelCity;
  }

  Future getListStation({String? id}) async {
    var res = await addressRepository.listStation(id.toInt());
    if (res != null && res != '' && res.data != null) {
      listStation = (res.data as List).map((e) => StationModel.fromJson(e)).toList();
      emit(StationSuccess());
    }
    return listStation;
  }
}
