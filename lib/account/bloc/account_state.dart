part of 'account_bloc.dart';

class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoaded extends AccountState {
  AccountLoaded({required this.user});
  final UserModel user;
}

class AccountLoading extends AccountState {}

class AccountLoadingFailure extends AccountState {
  AccountLoadingFailure({this.exeption});

  final Object? exeption;
}
