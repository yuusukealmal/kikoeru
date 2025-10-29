// flutter
import "package:flutter/material.dart";

// 3rd lib
import "package:shared_preferences/shared_preferences.dart";

// logger
import "package:kikoeru/main.dart";

class SharedPreferencesHelper with ChangeNotifier {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => _instance;
  SharedPreferencesHelper._internal();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void log(String type, String key, dynamic value) {
    logger.i("SharedPreferences $type\nkey: $key\nvalue: $value");
  }

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
    log("setString", key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value).then((value) {
      log("setInt", key, value);
    });
  }

  static Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value).then((value) {
      log("setDouble", key, value);
    });
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value).then((value) {
      log("setBool", key, value);
    });
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value).then((value) {
      log("setStringList", key, value);
    });
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  static Future<bool> remove(String key) async {
    return _prefs?.remove(key) ?? Future.value(false);
  }

  static Future<bool> delete() async {
    return _prefs?.clear() ?? Future.value(false);
  }

  static Future<void> reset() async {}
}
