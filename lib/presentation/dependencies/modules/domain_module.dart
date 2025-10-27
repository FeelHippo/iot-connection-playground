import 'package:apiClient/main.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class DomainModule {
  static UserRepository createUserRepository(Injector injector) =>
      UserRepository(
        injector.get<UserPreferences>(),
        injector.get<AuthProvider>(),
      );

  static AuthenticationRepository createAuthenticationRepository(
    Injector injector,
  ) => AuthenticationRepository(
    injector.get<AuthenticationProvider>(),
    injector.get<AuthProvider>(),
    injector.get<UserPreferences>(),
  );

  static AuthRepository createAuthRepository(Injector injector) =>
      AuthRepository(
        injector.get<AuthProvider>(),
        injector.get<UserRepository>(),
      );
}
