import 'package:todo_list/account/models/user_model.dart';
import '../api/account_api.dart';

class AccountService {
  AccountApi accountApi = AccountApi();
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
        positions: data['positions'][0],
        technologies: data['technologies'],
        userProjects: data['userProjects']);

    return user;
  }
}
