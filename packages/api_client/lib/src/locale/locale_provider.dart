import 'package:devicelocale/devicelocale.dart';

class LocaleProvider {
  Future<String> currentLocale() async {
    try {
      final String? locale = await Devicelocale.currentLocale;
      return locale?.replaceAll('_', '-') ?? 'en-GB';
    } catch (e) {
      return 'en-GB';
    }
  }

  Future<String> currentLocaleLanguage() async {
    final String currentLocale = await this.currentLocale();
    return currentLocale.split('-')[0];
  }
}
