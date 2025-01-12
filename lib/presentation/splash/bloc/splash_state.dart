part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class InitialSplashState extends SplashState {
  const InitialSplashState();

  @override
  List<Object> get props => <Object>[];
}

class LoadingSplashState extends SplashState {
  const LoadingSplashState();

  @override
  List<Object> get props => <Object>[];
}

class SplashToLoginState extends SplashState {
  const SplashToLoginState();

  @override
  List<Object> get props => <Object>[];
}

class SplashToRegistrationState extends SplashState {
  const SplashToRegistrationState();

  @override
  List<Object> get props => <Object>[];
}
