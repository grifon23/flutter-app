import 'package:todo_list/common/typing/option.dart';
import 'package:todo_list/user/typing/user_type.dart';

class UserPositionsList {
  List<Option> options = [
    Option(label: 'Manager', value: UserPosition.Manager),
    Option(label: 'Developer', value: UserPosition.Developer),
    Option(label: 'Tester', value: UserPosition.QA),
    Option(label: 'Designer', value: UserPosition.Designer),
    Option(label: 'Admin', value: UserPosition.Admin),
  ];
}
