import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Storage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setItem({required String key, required dynamic value}) async {
    final SharedPreferences prefs = await _prefs;
    String encodedMap = json.encode(value);
    prefs.setString(key, encodedMap);
  }

  Future<Map<String, dynamic>> getItem({required String key}) async {
    Map<String, dynamic> data = {};
    final SharedPreferences prefs = await _prefs;
    final String result = prefs.getString(key) ?? '';
    data["body"] = result != '' ? json.decode(result) : '';

    return data;
  }

  Future<void> removeItem({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(key);
  }
}
