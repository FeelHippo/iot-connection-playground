import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

@JsonSerializable()
class Credentials {
  Credentials({required this.credentials});

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);
  final CredentialsData? credentials;

  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}

@JsonSerializable()
class CredentialsData {
  CredentialsData({
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.sessionToken,
  });

  final String accessKeyId;
  final String secretAccessKey;
  final String sessionToken;

  factory CredentialsData.fromJson(Map<String, dynamic> json) =>
      _$CredentialsDataFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialsDataToJson(this);
}
