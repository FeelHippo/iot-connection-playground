import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.authenticationModel,
    this.isLoggedIn = false,
  });

  LoginState.isAuthenticated(
    this.authenticationModel,
  ) : isLoggedIn = true;

  final AuthenticationModel? authenticationModel;
  final bool isLoggedIn;

  @override
  List<Object?> get props => <Object?>[
    authenticationModel,
    isLoggedIn,
  ];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository)
    : super(
        LoginState(
          authenticationModel: null,
        ),
      );

  final AuthenticationRepository authenticationRepository;

  void authenticate({
    required String email,
    required String password,
  }) async {
    final AuthenticationModel authenticationModel =
        await authenticationRepository.doLogin(
          email: email,
          password: password,
        );

    if (authenticationModel.token.isNotEmpty) {
      emit(
        LoginState.isAuthenticated(authenticationModel),
      );
    }
  }
}
