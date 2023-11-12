import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? prefs;

  static init() async => prefs = await SharedPreferences.getInstance();

  dynamic get({String? key}) => prefs!.get(key!);
  String getString({String? key}) => prefs!.getString(key!) ?? '';
  int getInt({String? key}) => prefs!.getInt(key!) ?? 0;
  bool getBool({String? key}) => prefs!.getBool(key!) ?? false;
  double getDouble({String? key}) => prefs!.getDouble(key!) ?? 0.0;

  Future<bool> save({required String key, required dynamic value}) async {
    switch (value.runtimeType) {
      case String:
        return await prefs!.setString(key, value);
      case int:
        return await prefs!.setInt(key, value);
      case bool:
        return await prefs!.setBool(key, value);
      default:
        return await prefs!.setString(key, value.toString());
    }
  }

  Future<bool> remove({String? key}) async => await prefs!.remove(key!);

  // Future<bool> clear() async => await prefs!.clear();
}
