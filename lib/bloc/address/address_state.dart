part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressCitySuccess extends AddressState {
  final List<ListDataAddress> listCity;
  AddressCitySuccess({required this.listCity});
}

class AddressDistristSuccess extends AddressState {
  final List<ListDataAddress> listDistrist;
  AddressDistristSuccess({required this.listDistrist});
}

class AddressWardSuccess extends AddressState {
  final List<ListDataAddress> listWard;
  AddressWardSuccess({required this.listWard});
}

class SearchSuccess extends AddressState {
  SearchSuccess();
}
