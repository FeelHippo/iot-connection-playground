import 'package:giggle/presentation/onboarding/auth/auth_bloc/auth_bloc.dart';
import 'package:giggle/presentation/splash/bloc/splash_bloc.dart';
import 'package:injector/injector.dart';

class BlocModule {
  static SplashBloc createSplashBloc(Injector injector) => SplashBloc();

  static AuthBloc createAuthBloc(Injector injector) => AuthBloc(
        injector.get(),
        injector.get(),
        injector.get(),
      );
}
