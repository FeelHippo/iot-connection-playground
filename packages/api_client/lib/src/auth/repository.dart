import 'package:apiClient/main.dart';
import 'package:apiClient/src/requests/login.dart';
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
    required String userId,
    required String id,
    required String rawId,
    required String clientDataJSON,
    required String attestationObject,
    required List<String?> transports,
  }) async {
    return authenticationProvider.doRegisterFinish(
      registerRequest: RegisterFinishRequest(
        id: userId,
        data: RegisterFinishDataRequest(
          id: id,
          rawId: rawId,
          response: AuthenticatorAttestationResponseJSON(
            clientDataJSON: clientDataJSON,
            attestationObject: attestationObject,
          ),
          clientExtensionResults: new AuthenticationExtensionsClientOutputs(),
          type: 'public-key',
        ),
      ),
    );
  }

  Future<LoginStartModel> doLoginStart({
    required String email,
  }) async {
    return authenticationProvider.doLoginStart(
      loginRequest: LoginStartRequest(
        email: email,
      ),
    );
  }

  Future<AuthenticationModel> doLoginFinish({
    required String email,
    required String id,
    required String rawId,
    required String clientDataJSON,
    required String authenticatorData,
    required String signature,
  }) async {
    return authenticationProvider.doLoginFinish(
      loginRequest: LoginFinishRequest(
        name: email,
        data: LoginFinishDataRequest(
          id: id,
          rawId: rawId,
          response: AuthenticatorAssertionResponseJSON(
            clientDataJSON: clientDataJSON,
            authenticatorData: authenticatorData,
            signature: signature,
          ),
          clientExtensionResults: new AuthenticationExtensionsClientOutputs(),
          type: 'public-key',
        ),
      ),
    );
  }
}
