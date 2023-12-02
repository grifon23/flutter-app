import 'dart:convert';
import 'dart:js_util';

import 'package:dio/dio.dart';
import 'package:todo_list/config/access_config.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';

import '../../auth/api/auth_api.dart';

class RequestsService {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<void> fetchData() async {
    try {
      Response response = await dio.get('/path/to/your/endpoint');
      print(response.data);
    } on DioException catch (e) {
      print(e.message);
    }
  }

  Future<void> postData() async {
    try {
      Response response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': 'value'},
      );
      print(response.data);
    } on DioException catch (e) {
      print(e.message);
    }
  }

  Future<String> refreshToken() async {
    final authService = AuthApiService();
    final storage = StorageService();
    try {
      var refresfToken = storage.getItem('refreshToken');

      Response resp = await authService.getRefreshToken(refresfToken);

      await authService.saveSession(Session(
          refreshToken: resp.data['refreshToken'],
          accessToken: resp.data['accessToken']));
      print('refresh session $resp');
    } on DioException catch (e) {
      print(e.message);
    }
    return 'your_new_access_token';
  }
}
