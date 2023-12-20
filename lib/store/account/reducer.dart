import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/store/account/actions.dart';
import 'package:todo_list/store/state.dart';

AppState reducer(AppState state, dynamic action) => AppState(
    counter: _countReduce(state, action),
    text: _textReducer(state, action),
    user: _accountReducer(state, action));

int _countReduce(AppState state, dynamic action) {
  if (action is AddCount) {
    return state.counter + 1;
  }
  return state.counter;
}

String _textReducer(AppState state, dynamic action) {
  if (action is SetText) {
    return action.text;
  }
  return state.text;
}

UserModel? _accountReducer(AppState state, dynamic action) {
  if (action is SetAccount) {
    return action.userModel;
  }
  return state.user;
}
