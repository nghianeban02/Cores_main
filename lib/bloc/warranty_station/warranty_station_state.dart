part of 'warranty_station_cubit.dart';

@immutable
abstract class WarrantyStationState {}

class WarrantyStationInitial extends WarrantyStationState {}

class SearchCitySuccess extends WarrantyStationState {
  SearchCitySuccess();
}

class StationSuccess extends WarrantyStationState {
  StationSuccess();
}

class CitySuccess extends WarrantyStationState {
  final List<ListDataAddress> listCity;
  CitySuccess({required this.listCity});
}
