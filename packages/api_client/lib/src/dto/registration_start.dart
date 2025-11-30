import 'package:json_annotation/json_annotation.dart';

part 'registration_start.g.dart';

@JsonSerializable()
class RegistrationStartDto {
  RegistrationStartDto({
    required this.challenge,
    required this.rp,
    required this.user,
    required this.excludeCredentials,
  });

  final String challenge;
  final RelyingPartyDto rp;
  final UserDto user;
  final List<dynamic> excludeCredentials;

  factory RegistrationStartDto.fromJson(Map<String, dynamic> json) =>
      _$RegistrationStartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationStartDtoToJson(this);
}

@JsonSerializable()
class RelyingPartyDto {
  RelyingPartyDto({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  factory RelyingPartyDto.fromJson(Map<String, dynamic> json) =>
      _$RelyingPartyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RelyingPartyDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  UserDto({
    required this.id,
    required this.name,
    required this.displayName,
  });
  final String id;
  final String name;
  final String displayName;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
