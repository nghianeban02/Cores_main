part of 'cores_bloc_cubit.dart';

@immutable
abstract class CoresBlocState {}

class CoresBlocInitial extends CoresBlocState {}

class CoresOnchangeList extends CoresBlocState {
  final bool typeList;
  CoresOnchangeList({this.typeList = true});
}

class CoresOnchangeTabRegister extends CoresBlocState {
  final int index;
  CoresOnchangeTabRegister({this.index = 0});
}
