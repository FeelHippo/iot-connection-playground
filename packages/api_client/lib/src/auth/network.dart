import 'package:apiClient/main.dart';
import 'package:apiClient/src/dto/authentication.dart';
import 'package:apiClient/src/dto/user.dart';

class NetworkAuthProvider extends AuthenticationProvider {
  NetworkAuthProvider({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<AuthenticationModel> doLogin({
    required LoginRequest loginRequest,
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
  Future<AuthenticationModel> doRegister({
    required RegisterRequest registerRequest,
  }) async {
    final AuthenticationDto dto = await apiClient.register(
      registerRequest,
    );
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
  Future<BaseAuthModel> getUserById({required String id}) async {
    final UserDto dto = await apiClient.getUserById(id);
    final UserDataDto userData = dto.user;
    return BaseAuthModel(
      id: userData.id,
      email: userData.email,
      username: userData.username,
      firstName: userData.firstName,
      lastName: userData.lastName,
    );
  }
}
