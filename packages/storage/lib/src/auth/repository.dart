import 'package:apiClient/main.dart';
import 'package:storage/main.dart';

class AuthRepository {
  AuthRepository(
    this.authProvider,
    this.userRepository,
  );

  final AuthProvider authProvider;
  final UserRepository userRepository;

  Future<Map<String?, String?>> getStoredValues() async {
    return authProvider.getStoredValues();
  }

  Future<void> updateValues({
    String? name,
    String? accessToken,
    String? refreshToken,
  }) async {
    await authProvider.update(
      name: name,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Stream<AuthModel> get() async* {
    yield* authProvider.get();
  }

  Future<void> authorize({
    required AuthenticationModel authenticationModel,
  }) async {
    // store user id (email), auth + refresh tokens on device
    await authProvider.put(
      AuthModel(
        name: authenticationModel.name,
        accessToken: authenticationModel.accessToken,
        refreshToken: authenticationModel.refreshToken,
      ),
    );
  }
}
