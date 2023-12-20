import 'package:todo_list/account/models/user_model.dart';

class AddCount {}

class SetText {
  final String text;

  SetText({required this.text});
}

class SetAccount {
  final UserModel userModel;

  SetAccount({required this.userModel});
}
