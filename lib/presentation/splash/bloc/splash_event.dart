part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class CheckLoginEvent extends SplashEvent {
  const CheckLoginEvent();

  @override
  List<Object> get props => <Object>[];
}
