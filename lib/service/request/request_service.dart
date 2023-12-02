import 'package:dio/dio.dart';
import 'package:todo_list/config/access_config.dart';

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
  try {
    Response response = await dio.post(
      '/path/to/your/endpoint',
      data: {'key': 'value'},
    );
    print(response.data);
  } on DioException catch (e) {
    print(e.message);
  }
  // Perform a request to the refresh token endpoint and return the new access token.
  // You can replace this with your own implementation.
  return 'your_new_access_token';
}
