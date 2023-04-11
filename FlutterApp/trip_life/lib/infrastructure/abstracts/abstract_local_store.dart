abstract class AbstractLocalStore {
  bool? readBoolValue(String key);
  double? readDoubleValue(String key);
  int? readIntValue(String key);
  String? readStringValue(String key);
  Future<bool> saveBoolValue(String key, bool value);
  Future<bool> saveDoubleValue(String key, double value);
  Future<bool> saveIntValue(String key, int value);
  Future<bool> saveStringValue(String key, String value);
}
