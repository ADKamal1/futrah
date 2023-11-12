import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';

final CacheHelper prefs = instance<CacheHelper>();

class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    prefs.save(key: 'lang_key', value: languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    final cachedLanguageCode = prefs.get(key: 'lang_key');
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return 'ar';
    }
  }
}
