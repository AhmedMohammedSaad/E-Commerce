// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> _ensureInitialized() async {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized. Call SharedPreferencesHelper.init() first.");
    }
  }

  // Save data to SharedPreferences
  static Future<void> saveData({required String key, required dynamic value}) async {
    await _ensureInitialized();

    if (value is String) {
      await _preferences!.setString(key, value);
    } else if (value is int) {
      await _preferences!.setInt(key, value);
    } else if (value is double) {
      await _preferences!.setDouble(key, value);
    } else if (value is bool) {
      await _preferences!.setBool(key, value);
    } else if (value is List<String>) {
      await _preferences!.setStringList(key, value);
    } else {
      throw Exception("Unsupported value type");
    }
  }

  // Get data from SharedPreferences
  static dynamic getData({required String key}) {
    if (_preferences == null) return null;
    return _preferences!.get(key);
  }

  // Remove data from SharedPreferences
  static Future<void> removeData({required String key}) async {
    if (_preferences == null) return;
    await _preferences!.remove(key);
  }

  // Clear all data from SharedPreferences
  static Future<void> clearAll() async {
    if (_preferences == null) return;
    await _preferences!.clear();
  }
}
