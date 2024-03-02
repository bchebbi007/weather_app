import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesService {

  static SharedPreferencesService? _instance;

  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService> getInstance() async {
  debugPrint('SharedPreferencesService getInstance()');
    if (_instance == null) {
      _instance = SharedPreferencesService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance!;
  }


  ///load from shared preference
  dynamic getFromDisk(String key) {
    var value = _preferences?.get(key);
    return value;
  }

  ///save to shared preferences with generic types (Accepting : String,Bool,Int,Double,List<String>)
  void saveModelToDisk<T>(String key, T content) {
    if (content is String) {

      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }

  ///Delete from Shared Preferences with key
  deleteModelFromDisk(String key) => _preferences?.remove(key);

  ///Clear all shared preferences
  clearDisk() => _preferences!.clear();
}
