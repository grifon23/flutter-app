import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/store/account/actions.dart';
import '../../service/file_service/file_service.dart';
import '../api/account_api.dart';

class AccountService {
  final Store<dynamic> store;
  final AccountApi accountApi = AccountApi();
  AccountService({required this.store});

  Future<UserModel> loadAcount() async {
    final response = await accountApi.getAccountReq();

    final data = response.data as Map<String, dynamic>;
    final UserModel user = UserModel(
        name: data['name'],
        email: data['email'],
        lastName: data['lastName'],
        avatarUrl: data['avatarUrl'],
        phoneNumber: data['phoneNumber'],
        cooperationStartDate: data['cooperationStartDate'],
        birthDate: data['birthDate'],
        role: data['role'],
        positions: data['positions'] != null ? data['positions'][0] : null,
        technologies: data['technologies'],
        userProjects: data['userProjects'],
        id: data['id']);

    store.dispatch(SetAccount(userModel: user));

    return user;
  }

  Future updateAccount(Map<String, dynamic> payload) async {
    await accountApi.updateAccountReq(payload);
    await loadAcount();
  }
}
