import 'package:apiClient/main.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class DomainModule {
  static SomethingProvider createSomethingProvider(Injector injector) =>
      NetworkInterface(
        apiClient: injector.get<ApiClient>(),
        mapper: injector.get<SomethingMapper>(),
      );
  static SomethingInteractor createSomethingInteractor(Injector injector) =>
      SomethingInteractor(provider: injector.get<SomethingProvider>());

  static UserInteractor createUserInteractor(Injector injector) =>
      UserInteractor(
        injector.get<UserProvider>(),
        injector.get<UserPreferences>(),
        injector.get<AuthProvider>(),
      );

  static LoginInteractor createLoginInteractor(Injector injector) =>
      LoginInteractor(
        injector.get<LoginProvider>(),
        injector.get<AuthProvider>(),
        injector.get<UserProvider>(),
        injector.get<UserPreferences>(),
      );

  static AuthInteractor createAuthInteractor(Injector injector) =>
      AuthInteractor(
        injector.get<AuthProvider>(),
        injector.get<LocaleProvider>(),
        injector.get<LoginInteractor>(),
        injector.get<UserInteractor>(),
      );
}
