import 'package:dio/dio.dart';
import 'package:todo_list/auth/api/auth_api.dart';
import 'package:todo_list/config/access_config.dart';

import '../local_storage/local_storage_service.dart';

class RequestsService {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );
  final storage = StorageService();

  RequestsService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          var token = await storage.getItem('accessToken');
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            var resp = await getSession();
            await saveSession(resp);

            e.requestOptions.headers['Authorization'] =
                'Bearer ${resp.accessToken}';
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String path, {dynamic params}) async {
    try {
      Response response = await dio.get(
        path,
        queryParameters: params,
      );
      return response;
    } catch (e) {
      throw DioErrorWrapper(e);
    }
  }

  Future<Response> post(String path,
      {required Map<String, dynamic> data}) async {
    try {
      Response response = await dio.post(
        path,
        data: data,
      );
      return response;
    } catch (e) {
      throw DioErrorWrapper(e);
    }
  }

  Future<Response> put(String path,
      {required Map<String, dynamic> data}) async {
    try {
      Response response = await dio.put(
        path,
        data: data,
      );
      return response;
    } catch (e) {
      throw DioErrorWrapper(e);
    }
  }

  Future<Response> patch(String path,
      {required Map<String, dynamic> data}) async {
    try {
      Response response = await dio.put(
        path,
        data: data,
      );
      return response;
    } catch (e) {
      throw DioErrorWrapper(e);
    }
  }

  Future<Response> delete(String path, String id) async {
    try {
      Response response = await dio.delete(
        '$path/$id',
      );
      return response;
    } catch (e) {
      throw DioErrorWrapper(e);
    }
  }

  Future<Session> getSession() async {
    try {
      var refreshToken = await storage.getItem('refreshToken');

      var resp = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      final Session session = Session(
          refreshToken: resp.data['refreshToken'],
          accessToken: resp.data['accessToken']);
      return session;
    } on DioException catch (e) {
      print('Error during getSession: ${e.message}');
      throw DioErrorWrapper(e);
    }
  }

  Future saveSession(Session session) async {
    await storage.saveItem('refreshToken', session.refreshToken);
    await storage.saveItem('accessToken', session.accessToken);
  }
}

class DioErrorWrapper {
  final dynamic error;

  DioErrorWrapper(this.error);

  int? get statusCode {
    if (error is DioException) {
      return (error as DioException).response?.statusCode;
    }
    return null;
  }

  String? get errorMessage {
    if (error is DioException) {
      if ((error as DioException).response?.data != null) {
        return (error as DioException).response?.data.toString();
      } else {
        return (error as DioException).message;
      }
    }
    return error.toString();
  }
}
