part of 'splash_bloc.dart';

/// class SplashState
abstract class SplashState extends Equatable {
  /// Default Constructor
  const SplashState();
}

/// Class
class InitialSplashState extends SplashState {
  /// Default Constructor
  const InitialSplashState();

  @override
  List<Object> get props => <Object>[];
}

/// LoadingSplashState
class LoadingSplashState extends SplashState {
  /// Default Constructor
  const LoadingSplashState();

  @override
  List<Object> get props => <Object>[];
}

/// SplashToLoginState
class SplashToLoginState extends SplashState {
  /// Default Constructor
  const SplashToLoginState();

  @override
  List<Object> get props => <Object>[];
}

/// SplashToPromoState
class SplashToPromoState extends SplashState {
  /// Default Constructor
  const SplashToPromoState();

  @override
  List<Object> get props => <Object>[];
}
