import 'package:shared_preferences/shared_preferences.dart';

import 'apiService.dart';


class LocalStorage {
  // ─── Cached instance — avoids repeated getInstance() disk calls ───
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> _instance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<void> set(String key, String value) async {
    final prefs = await _instance();
    await prefs.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    final prefs = await _instance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await _instance();
    return prefs.getBool(key);
  }

  static Future<String?> get(String key) async {
    final prefs = await _instance();
    return prefs.getString(key);
  }

  static Future<void> clear() async {
    final prefs = await _instance();
    await prefs.clear();

    // ✅ Always wipe the in-memory token cache on logout
    Apiservices.updateCachedToken(null);
  }

  static Future<bool> containsKey(String key) async {
    final prefs = await _instance();
    return prefs.containsKey(key);
  }
}