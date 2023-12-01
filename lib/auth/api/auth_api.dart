import 'dart:convert';

import 'package:todo_list/config/access_config.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/service/local_storage/local_storage_service.dart';

class AuthApiService {
  Future loginReq(String email, String password) async {
    const url = "$BASE_URL/auth/login";
    final uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"email": email, "password": password, "deviceName": "m"}));
    if (response.statusCode == 201) {
      final storage = StorageService();
      var dataJson = jsonDecode(response.body);
      storage.saveItem('accessToken', dataJson['accessToken']);
    }
  }
}
