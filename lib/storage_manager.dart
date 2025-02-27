import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {

  // save any type
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  // get as string
  static Future read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var obj = prefs.getString(key);
    return obj;
  }

  // save as list
  static Future save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  // get as list
  static Future readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var obj = prefs.getStringList(key);
    return obj;
  }

  // remove
  static Future deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
  static Future clearData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}

