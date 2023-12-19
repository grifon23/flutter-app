part of 'account_bloc.dart';

class AccountEvent {}

class LoadAccount extends AccountEvent {}

class UpdateAccount extends AccountEvent {
  final Map<String, dynamic> updatedUser;

  UpdateAccount({required this.updatedUser});
}
