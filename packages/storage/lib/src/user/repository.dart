import 'package:storage/main.dart';

class UserRepository {
  UserRepository(
    this._userPreferences,
    this._authProvider,
  );

  final UserPreferences _userPreferences;
  final AuthProvider _authProvider;

  Future<bool> isThereCurrentUser() async {
    final AuthModel authModel = await _authProvider.get().first;
    return !authModel.isEmpty;
  }

  Future<void> logout() async {
    await clearUserData();
    return;
  }

  Future<dynamic> clearUserData() async {
    await _userPreferences.clearRegisteredDeviceToken();
    await _userPreferences.clearCurrentUserId();
    await _userPreferences.clearAllPref();
    await _userPreferences.clearAuth();
    await _authProvider.remove();
  }
}
