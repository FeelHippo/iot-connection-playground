import 'package:apiClient/main.dart';
import 'package:storage/main.dart';

class AuthenticationRepository {
  AuthenticationRepository(
    this.authenticationProvider,
    this.authProvider,
    this.userPreferences,
  );

  final AuthenticationProvider authenticationProvider;
  final AuthProvider authProvider;
  final UserPreferences userPreferences;

  Future<AuthenticationModel> doLogin({
    required String email,
    required String password,
  }) async {
    return authenticationProvider.doLogin(
      loginRequest: LoginRequest(
        email: email,
        password: password,
      ),
    );
  }

  Future<AuthenticationModel> doRegister({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    return authenticationProvider.doRegister(
      registerRequest: RegisterRequest(
        email: email,
        password: password,
        username: username,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  Future<BaseAuthModel> getUserById({required String id}) async {
    return authenticationProvider.getUserById(id: id);
  }
}
