part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.error,
    this.auth = const InitialAuthUiModel(),
  });

  final dynamic error;
  final AuthUiModel auth;

  AuthState copyWith({
    dynamic error,
    AuthUiModel? auth,
  }) {
    return AuthState(
      error: error ?? this.error,
      auth: auth ?? this.auth,
    );
  }

  @override
  List<Object?> get props => <Object?>[error, auth];
}

abstract class AuthUiModel extends Equatable {
  const AuthUiModel();
}

class InitialAuthUiModel extends AuthUiModel {
  const InitialAuthUiModel();

  @override
  List<Object?> get props => const <Object?>[];
}

class DeleteAccountUiModel extends AuthUiModel {
  const DeleteAccountUiModel();

  @override
  List<Object?> get props => const <Object?>[];
}

class UnauthorizedAuthUiModel extends AuthUiModel {
  const UnauthorizedAuthUiModel();

  @override
  List<Object?> get props => <Object?>[];
}

class AuthorizedAuthUiModel extends AuthUiModel {
  const AuthorizedAuthUiModel(this.user);

  final UserModel user;

  @override
  List<Object?> get props => <Object?>[user];
}
