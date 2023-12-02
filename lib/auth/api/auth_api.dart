import 'dart:convert';

import 'package:todo_list/config/access_config.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/service/local_storage/local_storage_service.dart';

class Session {
  String refreshToken;
  String accessToken;

  Session({
    required this.refreshToken,
    required this.accessToken,
  });
}

class AuthApiService {
  Future saveSession(Session session) async {
    final storage = StorageService();
    await storage.saveItem('refreshToken', session.refreshToken);
    await storage.saveItem('accessToken', session.accessToken);
  }

  Future loginReq(String email, String password) async {
    const url = "$BASE_URL/auth/login";
    final uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"email": email, "password": password, "deviceName": "m"}));
    print(response.statusCode);
    if (response.statusCode == 201) {
      var dataJson = jsonDecode(response.body);

      await saveSession(Session(
          accessToken: dataJson['accessToken'],
          refreshToken: dataJson['refreshToken']));
    }
  }

  Future signUpReq(Map<String, dynamic> payload) async {
    const url = "$BASE_URL/auth/register";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) {
      var dataJson = jsonDecode(response.body);
      await saveSession(Session(
          accessToken: dataJson['accessToken'],
          refreshToken: dataJson['refreshToken']));
    }
  }
}
