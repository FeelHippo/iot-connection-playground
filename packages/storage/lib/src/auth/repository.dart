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

  Future<UserModel?> authorize({
    required AuthenticationModel authenticationModel,
  }) async {
    // store auth token on device
    await authProvider.put(
      AuthModel(
        token: authenticationModel.token,
        userUid: authenticationModel.id,
      ),
    );
    return UserModel(
      id: authenticationModel.id,
      email: authenticationModel.email,
      username: authenticationModel.username,
      firstName: authenticationModel.firstName,
      lastName: authenticationModel.lastName,
    );
  }
}
