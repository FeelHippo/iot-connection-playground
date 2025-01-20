import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvUtils {
  static int getInt(String key, {int fallback = 0}) {
    final String value = dotenv.get(key, fallback: '$fallback');
    return int.parse(value);
  }

  static String getString(String key, {String fallback = ''}) {
    return dotenv.get(key, fallback: fallback);
  }

  static bool getBool(String key, {bool fallback = false}) {
    final String value = dotenv.get(key, fallback: '$fallback');
    return value.toLowerCase() == 'true' || value == '1';
  }

  static double getDouble(String key, {double fallback = 0.0}) {
    final String value = dotenv.get(key, fallback: '$fallback');
    return double.parse(value);
  }
}
