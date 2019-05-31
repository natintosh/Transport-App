import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class SecureStorage {
  static final storage = new FlutterSecureStorage();

  static Future<dynamic> getValueFromKey(String key) async {
    return await storage.read(key: key);
  }

  static void deleteValueFromKey(String key) async {
    storage.delete(key: key);
  }

  static void writeValueToKey(
      {@required String key, @required dynamic value}) async {
    storage.write(key: key, value: value);
  }
}
