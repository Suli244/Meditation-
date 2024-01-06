import 'package:shared_preferences/shared_preferences.dart';

class UniversalPrefs {
  static saveData(String key, dynamic value) async {
    final pref = await SharedPreferences.getInstance();
    if (value is int) {
      await pref.setInt(key, value);
    } else if (value is String) {
      await pref.setString(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else {
      await pref.setStringList(key, value);
    }
  }

  static Future<dynamic> readData(String key) async {
    final pref = await SharedPreferences.getInstance();
    dynamic result = pref.get(key);

    return result;
  }

  static Future<dynamic> readDataList(String key) async {
    final pref = await SharedPreferences.getInstance();
    dynamic result = pref.getStringList(key);
    return result;
  }

  static Future<bool> removeData(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }

  static Future<bool> clearData() async {
    final pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
