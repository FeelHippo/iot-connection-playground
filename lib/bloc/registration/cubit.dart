import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkeys/authenticator.dart';
import 'package:passkeys/types.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    required this.authenticationModel,
    required this.email,
    required this.username,
    this.isLoggedIn = false,
  });

  RegistrationState.isAuthenticated(
    this.authenticationModel,
    this.email,
    this.username,
  ) : isLoggedIn = true;

  final AuthenticationModel? authenticationModel;
  final String? email;
  final String? username;
  final bool isLoggedIn;

  @override
  List<Object?> get props => <Object?>[authenticationModel, isLoggedIn];
}

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this.authenticationRepository)
    : super(
        RegistrationState(
          authenticationModel: null,
          email: null,
          username: null,
        ),
      );

  final AuthenticationRepository authenticationRepository;

  void register({required String email, required String username}) async {
    final PasskeyAuthenticator passkeyAuthenticator = PasskeyAuthenticator();
    final RegistrationStartModel webAuthnChallenge =
        await authenticationRepository.registerStart(
          email: email,
          username: username,
        );

    final RegisterRequestType challenge = RegisterRequestType(
      // String
      challenge: webAuthnChallenge.challenge,
      relyingParty: RelyingPartyType(
        name: webAuthnChallenge.rp.name,
        id: webAuthnChallenge.rp.id,
      ),
      user: UserType(
        displayName: webAuthnChallenge.user.displayName,
        name: webAuthnChallenge.user.name,
        id: webAuthnChallenge.user.id,
      ),
      excludeCredentials:
          webAuthnChallenge.excludeCredentials as List<CredentialType>,
    );

    final RegisterResponseType platformRes = await passkeyAuthenticator
        .register(challenge);

    final AuthenticationModel authenticationModel =
        await authenticationRepository.registerFinish(
          userId: webAuthnChallenge.user.id,
          id: platformRes.id,
          rawId: platformRes.rawId,
          clientDataJSON: platformRes.clientDataJSON,
          attestationObject: platformRes.attestationObject,
          transports: platformRes.transports,
        );

    if (authenticationModel.accessToken.isNotEmpty) {
      emit(
        RegistrationState.isAuthenticated(authenticationModel, email, username),
      );
    }
  }
}
