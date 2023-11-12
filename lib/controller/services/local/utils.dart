import 'dart:developer';

import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';

class Utils {
  final CacheHelper prefs = instance<CacheHelper>();

  /// save to local
  Future<bool> saveLocal({required String key, dynamic val}) async =>
      await prefs.save(key: key, value: val);

  /// get from local

  String getToken() => prefs.get(key: 'token');
  String getUid() => prefs.get(key: 'uid');
  int getUserId() => prefs.get(key: 'userId');
  String getPhone() => prefs.get(key: 'phone');

  /// clear local
  Future<bool> clearLocal() async {
    return await prefs.remove(key: 'token').then((value) {
      if (value) {
        prefs.remove(key: 'uid');
        prefs.remove(key: 'userId');
        prefs.remove(key: 'phone');
      }
      return value;
    });
  }

  void get printLocal {
    log('uid=> <${AppStrings.userUid}>');
    log('userId=> <${AppStrings.userId}>');
    log('phone=> <${AppStrings.userPhone}>');
    log('token=> <${AppStrings.loginToken}>');
  }

  void get getAllLocal {
    AppStrings.loginToken = getToken();
    AppStrings.userPhone = getPhone();
    AppStrings.userUid = getUid();
    AppStrings.userId = getUserId();
  }

  Future<bool> removeToken() async => await prefs.remove(key: 'token');
  Future<bool> removeUid() async => await prefs.remove(key: 'uid');
  Future<bool> removePhone() async => await prefs.remove(key: 'phone');
  Future<bool> removeUserId() async => await prefs.remove(key: 'userId');

  // Future<bool> removeAll() async {
  //   return await prefs.clear().then((value) {
  //     if (value) printLocal;
  //     return value;
  //   });
  // }
}
