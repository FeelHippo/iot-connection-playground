import 'package:apiClient/main.dart';
import 'package:storage/main.dart';

class AuthRepository {
  AuthRepository(
    this.authProvider,
    this.userRepository,
  );

  final AuthProvider authProvider;
  final UserRepository userRepository;

  Stream<AuthModel> get() async* {
    yield* authProvider.get();
  }

  Future<void> authorize({
    required AuthenticationModel authenticationModel,
  }) async {
    // store auth token on device
    await authProvider.put(
      AuthModel(
        accessToken: authenticationModel.accessToken,
        refreshToken: authenticationModel.refreshToken,
      ),
    );
  }
}
