import 'package:todo_list/account/models/user_model.dart';

class AppState {
  final int counter;
  final String text;
  final UserModel? user;
  AppState({required this.counter, required this.text, this.user});
}
