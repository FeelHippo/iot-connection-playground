import 'package:apiClient/main.dart';

abstract class AuthenticationProvider {
  Future<AuthenticationModel> doLogin({
    required LoginRequest loginRequest,
  });

  Future<AuthenticationModel> doRegister({
    required RegisterRequest registerRequest,
  });

  Future<BaseAuthModel> getUserById({
    required String id,
  });
}
