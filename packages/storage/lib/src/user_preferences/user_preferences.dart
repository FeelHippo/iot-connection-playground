abstract class UserPreferences {
  // Common
  Future<void> putString({required String key, required String value});
  Future<String> getString({required String key});
  Future<void> putBool({required String key, required bool value});
  Future<bool> getBool({required String key});
  Future<void> putInt({required String key, required int value});
  Future<int> getInt({required String key});
  Future<void> putDouble({required String key, required double value});
  Future<double> getDouble({required String key});

  // App
  Future<void> clearAllPref();

  Future<void> putCurrentUserId(String id);
  Future<String?> getCurrentUserId();
  Future<void> clearCurrentUserId();

  Future<void> putRegisteredDeviceToken(String token);
  Future<String?> getRegisteredDeviceToken();
  Future<void> clearRegisteredDeviceToken();

  Future<void> clearAuth();

  // User locale
  Future<void> putUserLocale(String locale);
  Future<String?> getUserLocale();
}
