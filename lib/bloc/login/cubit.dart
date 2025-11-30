import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkeys/authenticator.dart';
import 'package:passkeys/types.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.authenticationModel,
    this.isLoggedIn = false,
  });

  LoginState.isAuthenticated(this.authenticationModel) : isLoggedIn = true;

  final AuthenticationModel? authenticationModel;
  final bool isLoggedIn;

  @override
  List<Object?> get props => <Object?>[authenticationModel, isLoggedIn];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository)
    : super(LoginState(authenticationModel: null));

  final AuthenticationRepository authenticationRepository;

  void login({required String email}) async {
    final PasskeyAuthenticator passkeyAuthenticator = PasskeyAuthenticator();
    final LoginStartModel webAuthnChallenge = await authenticationRepository
        .doLoginStart(email: email);

    final AuthenticateResponseType platformRes = await passkeyAuthenticator
        .authenticate(
          AuthenticateRequestType(
            relyingPartyId: webAuthnChallenge.rpId,
            challenge: webAuthnChallenge.challenge,
            mediation: MediationType.Required,
            preferImmediatelyAvailableCredentials: false,
          ),
        );

    final AuthenticationModel authenticationModel =
        await authenticationRepository.doLoginFinish(
          email: email,
          id: platformRes.id,
          rawId: platformRes.rawId,
          clientDataJSON: platformRes.clientDataJSON,
          authenticatorData: platformRes.authenticatorData,
          signature: platformRes.signature,
        );

    if (authenticationModel.accessToken.isNotEmpty) {
      emit(LoginState.isAuthenticated(authenticationModel));
    }
  }
}
