import 'package:apiClient/main.dart';

abstract class AuthenticationProvider {
  Future<RegistrationStartModel> doRegisterStart({
    required RegisterStartRequest registerRequest,
  });

  Future<AuthenticationModel> doRegisterFinish({
    required RegisterFinishRequest registerRequest,
  });

  Future<LoginStartModel> doLoginStart({
    required LoginStartRequest loginRequest,
  });

  Future<AuthenticationModel> doLoginFinish({
    required LoginFinishRequest loginRequest,
  });

  Future<UserDataModel> getUserData();
}
