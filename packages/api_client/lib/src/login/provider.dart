import 'package:apiClient/src/login/model.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:apiClient/src/user/model.dart';

abstract class LoginProvider {
  Future<String> getCurrentUserId(String token);

  Future<LoginModel> doLogin({required LoginRequest loginRequest});

  Future<UserModel> getCurrentUser({required String token});
}
