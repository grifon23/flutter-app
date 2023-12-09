import 'package:localstorage/localstorage.dart';

class StorageService {
  final LocalStorage storage = LocalStorage('storage');

  Future<dynamic> saveItem(String key, String value) async {
    await storage.ready;
    return await storage.setItem(key, value);
  }

  Future<String?> getItem(String key) async {
    await storage.ready;
    return await storage.getItem(key);
  }

  Future removeItem(String key) async {
    await storage.ready;
    return await storage.deleteItem(key);
  }
}
