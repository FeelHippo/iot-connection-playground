import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    required this.authenticationModel,
    this.isLoggedIn = false,
  });

  RegistrationState.isAuthenticated(
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

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this.authenticationRepository)
    : super(
        RegistrationState(
          authenticationModel: null,
        ),
      );

  final AuthenticationRepository authenticationRepository;

  void register({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    final AuthenticationModel authenticationModel =
        await authenticationRepository.doRegister(
          email: email,
          password: password,
          username: username,
          firstName: firstName,
          lastName: lastName,
        );

    if (authenticationModel.token.isNotEmpty) {
      emit(
        RegistrationState.isAuthenticated(authenticationModel),
      );
    }
  }
}
