import 'package:shared_preferences/shared_preferences.dart';

class MyInfoPrefs {
  static void saveInfo({
    required String name,
    required String value,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, value);


  }

  static void deleteInfo({required String name}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(name);
  }

static Future<String?> getInfo({required String name}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(name);
}

  
}
