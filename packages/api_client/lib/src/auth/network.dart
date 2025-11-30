import 'package:apiClient/main.dart';

class NetworkAuthProvider extends AuthenticationProvider {
  NetworkAuthProvider({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<RegistrationStartModel> doRegisterStart({
    required RegisterStartRequest registerRequest,
  }) async {
    final RegistrationStartDto dto = await apiClient.registerStart(
      registerRequest,
    );
    return RegistrationStartModel(
      challenge: dto.challenge,
      rp: RelyingPartyModel(
        id: dto.rp.id,
        name: dto.rp.name,
      ),
      user: UserModel(
        id: dto.user.id,
        name: dto.user.name,
        displayName: dto.user.displayName,
      ),
      excludeCredentials: dto.excludeCredentials,
    );
  }

  @override
  Future<AuthenticationModel> doRegisterFinish({
    required RegisterFinishRequest registerRequest,
  }) async {
    final AuthenticationDto dto = await apiClient.registerFinish(
      registerRequest,
    );
    return AuthenticationModel(
      accessToken: dto.accessToken,
      refreshToken: dto.refreshToken,
    );
  }

  @override
  Future<AuthenticationModel> doLoginStart({
    required LoginStartRequest loginRequest,
  }) async {
    final AuthenticationDto dto = await apiClient.login(loginRequest);
    return AuthenticationModel(
      token: dto.token,
      id: dto.id,
      email: dto.email,
      username: dto.username,
      firstName: dto.firstName,
      lastName: dto.lastName,
    );
  }

  @override
  Future<AuthenticationModel> doLoginFinish({
    required LoginFinishRequest loginRequest,
  }) async {
    final AuthenticationDto dto = await apiClient.login(loginRequest);
    return AuthenticationModel(
      token: dto.token,
      id: dto.id,
      email: dto.email,
      username: dto.username,
      firstName: dto.firstName,
      lastName: dto.lastName,
    );
  }
}
