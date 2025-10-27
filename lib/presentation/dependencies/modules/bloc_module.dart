import 'package:apiClient/main.dart';
import 'package:giggle/bloc/auth/auth_bloc.dart';
import 'package:giggle/bloc/locales/cubit.dart';
import 'package:giggle/bloc/login/cubit.dart';
import 'package:giggle/bloc/registration/cubit.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class BlocModule {
  static AuthBloc createAuthBloc(Injector injector) => AuthBloc(
    injector.get<AuthRepository>(),
    injector.get<AuthenticationRepository>(),
  );

  static LoginCubit createLoginCubit(Injector injector) =>
      LoginCubit(injector.get<AuthenticationRepository>());

  static RegistrationCubit createRegistrationCubit(Injector injector) =>
      RegistrationCubit(injector.get<AuthenticationRepository>());

  static LocaleCubit createLocaleCubit(Injector injector) =>
      LocaleCubit(localeProvider: injector.get<LocaleProviderInterface>());
}
