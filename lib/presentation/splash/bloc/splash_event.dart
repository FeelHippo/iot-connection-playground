part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class IntroEvent extends SplashEvent {
  const IntroEvent();

  @override
  List<Object> get props => <Object>[];
}
