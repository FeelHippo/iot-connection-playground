import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class RegisterStartRequest {
  RegisterStartRequest({
    required this.email,
    required this.username,
  });

  final String email;
  final String username;

  factory RegisterStartRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterStartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterStartRequestToJson(this);
}

@JsonSerializable()
class RegisterFinishRequest {
  RegisterFinishRequest({
    required this.id,
    required this.rawId,
    required this.response,
    required this.clientExtensionResults,
    required this.type,
  });

  final String id;
  final String rawId;
  final AuthenticatorAttestationResponseJSON response;
  final AuthenticationExtensionsClientOutputs clientExtensionResults;
  final String type;

  factory RegisterFinishRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterFinishRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterFinishRequestToJson(this);
}

@JsonSerializable()
class AuthenticatorAttestationResponseJSON {
  AuthenticatorAttestationResponseJSON({
    required this.clientDataJSON,
    required this.attestationObject,
  });

  final String clientDataJSON;
  final String attestationObject;

  factory AuthenticatorAttestationResponseJSON.fromJson(
    Map<String, dynamic> json,
  ) => _$AuthenticatorAttestationResponseJSONFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AuthenticatorAttestationResponseJSONToJson(this);
}

@JsonSerializable()
class AuthenticationExtensionsClientOutputs {
  AuthenticationExtensionsClientOutputs({
    this.appid,
    this.credProps,
    this.hmacCreateSecret,
  });
  final bool? appid;
  final CredentialPropertiesOutput? credProps;
  final bool? hmacCreateSecret;
}

@JsonSerializable()
class CredentialPropertiesOutput {
  CredentialPropertiesOutput({this.rk});
  final bool? rk;
}
