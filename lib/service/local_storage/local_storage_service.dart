import 'package:localstorage/localstorage.dart';

class StorageService {
  final LocalStorage storage = LocalStorage('storage');

  Future saveItem(String key, String value) async {
    return await storage.setItem(key, value);
  }

  getItem(String key) {
    return storage.getItem(key);
  }

  void removeItem(String key) {
    storage.deleteItem(key);
  }
}
