import 'package:apiClient/main.dart';
import 'package:apiClient/src/requests/register.dart';
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

  Future<RegistrationStartModel> registerStart({
    required String email,
    required String username,
  }) async {
    return authenticationProvider.doRegisterStart(
      registerRequest: RegisterStartRequest(
        email: email,
        username: username,
      ),
    );
  }

  Future<AuthenticationModel> registerFinish({
    required String id,
    required String rawId,
    required String clientDataJSON,
    required String attestationObject,
    required List<String?> transports,
  }) async {
    return authenticationProvider.doRegisterFinish(
      registerRequest: RegisterFinishRequest(
        id: id,
        rawId: rawId,
        response: AuthenticatorAttestationResponseJSON(
          clientDataJSON: clientDataJSON,
          attestationObject: attestationObject,
        ),
        clientExtensionResults: AuthenticationExtensionsClientOutputs(),
        type: 'public-key',
      ),
    );
  }

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

  Future<BaseAuthModel> getUserById({required String id}) async {
    return authenticationProvider.getUserById(id: id);
  }
}
