import 'package:mobile/imports.dart';

class StorageUtils {
  static Future saveToStorage(
      FlutterSecureStorage storage, String key, String token) async {
    var writeToken = await storage.write(key: key, value: token);
    return writeToken;
  }

  static Future<String?> getFromStorage(
      FlutterSecureStorage storage, String key) async {
    var writeToken = await storage.read(key: key);
    return writeToken;
  }
}
