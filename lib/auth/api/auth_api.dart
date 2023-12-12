import 'package:todo_list/service/request/request_service.dart';

class Session {
  String refreshToken;
  String accessToken;

  Session({
    required this.refreshToken,
    required this.accessToken,
  });
}

class AuthApi {
  RequestsService api = RequestsService();

  Future loginReq(String email, String password) async {
    return api.post('/auth/login',
        data: {'email': email, 'password': password, 'deviceName': 'm'});
  }

  Future signUpReq(Map<String, dynamic> payload) async {
    return api.post('/auth/register', data: payload);
  }
}
