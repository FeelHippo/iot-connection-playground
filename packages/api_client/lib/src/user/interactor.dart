import 'dart:io';

import 'package:apiClient/src/auth/model.dart';
import 'package:apiClient/src/auth/provider.dart';
import 'package:apiClient/src/user/model.dart';
import 'package:apiClient/src/user/provider.dart';
import 'package:fimber/fimber.dart';
import 'package:storage/main.dart';

class UserInteractor {
  UserInteractor(
    this._userProvider,
    this._userPreferences,
    this._authProvider,
  );
  final UserProvider _userProvider;
  final UserPreferences _userPreferences;
  final AuthProvider _authProvider;

  Future<bool> isThereCurrentUser() async {
    final String? userId = await _userPreferences.getCurrentUserId();
    final AuthModel authModel = await _authProvider.get().first;
    return userId != null && !authModel.isEmpty;
  }

  Future<UserModel?> getCurrentUser({bool refresh = false}) async {
    final String? userId = await _userPreferences.getCurrentUserId();
    if (userId == null) {
      await clearUserData();
      return null;
    }
    final UserModel? user = await _userProvider.get(userId, refresh: refresh);
    return user;
  }

  Future<void> setDeviceToken(String token, {bool? isIOS}) async {
    String updatedToken = token;
    if (isIOS ?? Platform.isIOS) {
      updatedToken = token.toLowerCase();
    }
    final UserModel? user = await getCurrentUser();
    if (user != null) {
      await _userPreferences.putRegisteredDeviceToken(updatedToken);
    }
    return;
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

  Future<void> updateToken({bool? isIOS}) async {
    if (isIOS ?? Platform.isIOS) {
      final UserModel? user = await getCurrentUser();
      final String? deviceToken =
          await _userPreferences.getRegisteredDeviceToken();
      if (user != null &&
          deviceToken != null &&
          deviceToken.toLowerCase() != deviceToken) {
        try {
          await setDeviceToken(deviceToken, isIOS: isIOS);
        } catch (e, stacktrace) {
          Fimber.e("can' delete device token", ex: e, stacktrace: stacktrace);
        }
      }
    }
    return;
  }
}
