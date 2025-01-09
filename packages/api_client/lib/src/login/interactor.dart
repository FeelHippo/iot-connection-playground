import 'package:apiClient/src/auth/model.dart';
import 'package:apiClient/src/auth/provider.dart';
import 'package:apiClient/src/login/model.dart';
import 'package:apiClient/src/login/provider.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:apiClient/src/user/model.dart';
import 'package:apiClient/src/user/provider.dart';
import 'package:storage/main.dart';

class LoginInteractor {
  LoginInteractor(
    this.loginProvider,
    this.authProvider,
    this.userProvider,
    this.userPreferences,
  );

  final LoginProvider loginProvider;
  final AuthProvider authProvider;
  final UserProvider userProvider;
  final UserPreferences userPreferences;

  Future<void> login(
    String token, {
    bool callCurrentUserId = true,
    String id = '',
  }) async {
    String userId;
    if (callCurrentUserId) {
      userId = await loginProvider.getCurrentUserId(token);
    } else {
      userId = id;
    }
    await userPreferences.putCurrentUserId(userId);
    await authProvider.put(AuthModel(token: token));
    await userProvider.get(userId, refresh: true);
    return;
  }

  Future<LoginModel> doLogin({required LoginRequest loginRequest}) async {
    return loginProvider.doLogin(loginRequest: loginRequest);
  }

  Future<UserModel> getCurrentUser({required String token}) async {
    return loginProvider.getCurrentUser(token: token);
  }
}
