part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class LoginLoading extends AccountState {
  final bool isLoading;
  LoginLoading({this.isLoading = false});
}

class GetUserLoading extends AccountState {
  final bool isLoading;
  GetUserLoading({this.isLoading = false});
}

class GetUserSuccess extends AccountState {
  final InfoUserModel infoUserModel;
  GetUserSuccess({required this.infoUserModel});
}
