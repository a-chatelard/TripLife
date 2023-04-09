import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_local_store.dart';

class SharedPreferencesLocalStore implements AbstractLocalStore {
  SharedPreferencesLocalStore._();

  static Future<SharedPreferencesLocalStore> create() async {
    var sharedPreferencesLocalStore = SharedPreferencesLocalStore._();

    _sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferencesLocalStore;
  }

  static SharedPreferences? _sharedPreferences;

  @override
  bool? readBoolValue(String key) {
    return _sharedPreferences!.getBool(key);
  }

  @override
  double? readDoubleValue(String key) {
    return _sharedPreferences!.getDouble(key);
  }

  @override
  int? readIntValue(String key) {
    return _sharedPreferences!.getInt(key);
  }

  @override
  String? readStringValue(String key) {
    return _sharedPreferences!.getString(key);
  }

  @override
  Future<bool> saveBoolValue(String key, bool value) {
    return _sharedPreferences!.setBool(key, value);
  }

  @override
  Future<bool> saveDoubleValue(String key, double value) {
    return _sharedPreferences!.setDouble(key, value);
  }

  @override
  Future<bool> saveIntValue(String key, int value) {
    return _sharedPreferences!.setInt(key, value);
  }

  @override
  Future<bool> saveStringValue(String key, String value) {
    return _sharedPreferences!.setString(key, value);
  }
}
