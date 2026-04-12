import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._internal();

  static final SharedPref _instance = SharedPref._internal();

  static SharedPref get instance => _instance;

  SharedPreferences? _prefs;

  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw ('Error initializing SharedPreferences: $e');
    }
  }

  Future<bool> setKeyValue(String key, dynamic value) async {
    if (_prefs == null) return false;

    if (value is String) {
      return await _prefs!.setString(key, value);
    }

    if (value is bool) {
      return await _prefs!.setBool(key, value);
    }

    if (value is int) {
      return await _prefs!.setInt(key, value);
    }

    throw Exception('Unsupported type');
  }

  Object? getKeyValue(String key) {
    return _prefs?.get(key);
  }
}
