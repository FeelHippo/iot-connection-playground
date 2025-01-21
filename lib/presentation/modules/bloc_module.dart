import 'package:giggle/presentation/onboarding/auth/auth_bloc/auth_bloc.dart';
import 'package:giggle/presentation/onboarding/locales/cubit.dart';
import 'package:giggle/presentation/splash/bloc/splash_bloc.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class BlocModule {
  static LocaleCubit createLocaleCubit(Injector injector) =>
      LocaleCubit(localeProvider: injector.get<LocaleProviderInterface>());
  static SplashBloc createSplashBloc(Injector injector) => SplashBloc();

  static AuthBloc createAuthBloc(Injector injector) => AuthBloc(
        injector.get(),
        injector.get(),
        injector.get(),
      );
}
