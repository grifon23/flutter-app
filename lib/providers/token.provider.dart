import 'package:flutter/material.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';

class TokenProvider extends ChangeNotifier {
  String? token;

  TokenProvider({this.token});

  setIsToken(String newToken) async {
    token = newToken;
    notifyListeners();
  }

  Future logout() async {
    await StorageService().removeItem('accessToken');
    token = null;
    notifyListeners();
  }
}
