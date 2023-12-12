import 'package:todo_list/auth/api/auth_api.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';

class AuthService {
  final authApi = AuthApi();
  final storage = StorageService();

  Future login(String email, String password) async {
    var response = await authApi.loginReq(email, password);

    await saveSession(Session(
        refreshToken: response.data['refreshToken'],
        accessToken: response.data['accessToken']));
    return response;
  }

  Future signUp(Map<String, dynamic> payload) async {
    var response = await authApi.signUpReq(payload);
    await saveSession(Session(
        refreshToken: response.data['refreshToken'],
        accessToken: response.data['accessToken']));
    return response;
  }

  Future saveSession(Session session) async {
    await storage.saveItem('refreshToken', session.refreshToken);
    await storage.saveItem('accessToken', session.accessToken);
  }
}
