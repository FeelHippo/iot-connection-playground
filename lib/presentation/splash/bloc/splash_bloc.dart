import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const InitialSplashState()) {
    on<SplashEvent>(handleSplashEvent);
  }

  Future<void> handleSplashEvent(
    SplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(const LoadingSplashState());

    await Future<void>.delayed(const Duration(seconds: 2));

    emit(const SplashToPromoState());
  }
}
