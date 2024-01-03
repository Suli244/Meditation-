import 'package:shared_preferences/shared_preferences.dart';

class FirstOpenMeditation {
  static Future<bool> getFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isOpened') ?? false;
  }

  static Future<void> setFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOpened', true);
  }
}
