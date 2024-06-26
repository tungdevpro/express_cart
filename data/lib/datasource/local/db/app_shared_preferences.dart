import 'package:shared_preferences/shared_preferences.dart' as sp;

class AppSharedPreferences {
  final sp.SharedPreferences prefs;

  const AppSharedPreferences({
    required this.prefs,
  });

  Object? get(String key) => prefs.get(key);

  bool? getBool(String key) => prefs.getBool(key);

  int? getInt(String key) => prefs.getInt(key);

  double? getDouble(String key) => prefs.getDouble(key);

  String? getString(String key) => prefs.getString(key);

  bool containsKey(String key) => prefs.containsKey(key);

  Future<bool> setBool(String key, bool value) => prefs.setBool(key, value);

  Future<bool> setInt(String key, int value) => prefs.setInt(key, value);

  Future<bool> setDouble(String key, double value) => prefs.setDouble(key, value);

  Future<bool> setString(String key, String value) => prefs.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) => prefs.setStringList(key, value);

  Future<bool> remove(String key) => prefs.remove(key);

  Future<bool> clear() => prefs.clear();
}
