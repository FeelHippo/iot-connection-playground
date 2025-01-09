import 'package:apiClient/main.dart';
import 'package:apiClient/src/auth/model.dart';
import 'package:apiClient/src/auth/provider.dart';
import 'package:apiClient/src/login/interactor.dart';
import 'package:apiClient/src/user/interactor.dart';
import 'package:apiClient/src/user/model.dart';

class AuthInteractor {
  AuthInteractor(
    this.authProvider,
    this.localeProvider,
    this.loginInteractor,
    this.userInteractor,
  );
  final AuthProvider authProvider;
  final LocaleProvider localeProvider;
  final LoginInteractor loginInteractor;
  final UserInteractor userInteractor;

  Stream<AuthModel> get() async* {
    yield* authProvider.get();
  }

  Future<UserModel?> authorize(String token) async {
    UserModel? user = await userInteractor.getCurrentUser();
    if (user == null) {
      await loginInteractor.login(token);
      user = await userInteractor.getCurrentUser();
    }
    return user;
  }
}
