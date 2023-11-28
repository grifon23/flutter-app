import 'package:localstorage/localstorage.dart';

class StorageService {
  final LocalStorage storage = LocalStorage('storage');

  void saveItem(String key, String value) {
    storage.setItem(key, value);
  }

  String getItem(String key) {
    return storage.getItem(key);
  }

  void removeItem(String key) {
    storage.deleteItem(key);
  }
}
