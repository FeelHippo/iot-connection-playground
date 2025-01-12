import 'package:go_active/presentation/onboarding/auth/auth_bloc/auth_bloc.dart';
import 'package:go_active/presentation/splash/bloc/splash_bloc.dart';
import 'package:injector/injector.dart';

class BlocModule {
  static SplashBloc createSplashBloc(Injector injector) => SplashBloc();

  static AuthBloc createAuthBloc(Injector injector) => AuthBloc(
        injector.get(),
        injector.get(),
        injector.get(),
      );
}
