part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class FetchAuthEvent extends AuthEvent {
  const FetchAuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class SyncUserStateAuthEvent extends AuthEvent {
  const SyncUserStateAuthEvent({required this.auth});

  final AuthModel auth;

  @override
  List<Object> get props => <Object>[auth];
}

class CompleteAuthorization extends AuthEvent {
  const CompleteAuthorization({
    required this.authenticationModel,
    required this.email,
    this.username,
  });

  final AuthenticationModel authenticationModel;
  final String email;
  final String? username;

  @override
  List<Object?> get props => <Object?>[authenticationModel, email, username];
}

class SignOutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => const <Object>[];
}
