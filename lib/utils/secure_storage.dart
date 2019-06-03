import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class SecureStorage {
  static final storage = new FlutterSecureStorage();
  static String value;

  static Future<String> getValueFromKey(String key) async {
    String value = await storage.read(key: key);
    return value;
  }

  static getValue(String key) {
    getValueFromKey(key);
    return value;
  }

  static void deleteValueFromKey(String key) async {
    storage.delete(key: key);
  }

  static void writeValueToKey(
      {@required String key, @required String value}) async {
    storage.write(key: key, value: value);
  }
}
