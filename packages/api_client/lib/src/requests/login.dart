import 'package:apiClient/main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginStartRequest {
  LoginStartRequest({
    required this.email,
  });

  final String email;

  factory LoginStartRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginStartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStartRequestToJson(this);
}

@JsonSerializable()
class LoginFinishRequest {
  LoginFinishRequest({
    required this.name,
    required this.data,
  });

  final String name;
  final LoginFinishDataRequest data;

  factory LoginFinishRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginFinishRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginFinishRequestToJson(this);
}

@JsonSerializable()
class LoginFinishDataRequest {
  LoginFinishDataRequest({
    required this.id,
    required this.rawId,
    required this.response,
    required this.clientExtensionResults,
    required this.type,
  });

  final String id;
  final String rawId;
  final AuthenticatorAssertionResponseJSON response;
  final AuthenticationExtensionsClientOutputs clientExtensionResults;
  final String type;

  factory LoginFinishDataRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginFinishDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginFinishDataRequestToJson(this);
}

@JsonSerializable()
class AuthenticatorAssertionResponseJSON {
  AuthenticatorAssertionResponseJSON({
    required this.clientDataJSON,
    required this.authenticatorData,
    required this.signature,
  });

  final String clientDataJSON;
  final String authenticatorData;
  final String signature;

  factory AuthenticatorAssertionResponseJSON.fromJson(
    Map<String, dynamic> json,
  ) => _$AuthenticatorAssertionResponseJSONFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AuthenticatorAssertionResponseJSONToJson(this);
}
