import 'package:storage/main.dart';

abstract class LocaleProviderInterface {
  Future<void> writeLocaleToPrefs(String languageCode);
  Future<String?> readLocaleFromPrefs();
}

class StoreLocaleProvider extends LocaleProviderInterface {
  StoreLocaleProvider(this.userPreferences);

  final UserPreferences userPreferences;

  @override
  Future<void> writeLocaleToPrefs(String languageCode) async {
    userPreferences.putUserLocale(languageCode);
  }

  @override
  Future<String?> readLocaleFromPrefs() {
    return userPreferences.getUserLocale();
  }
}
