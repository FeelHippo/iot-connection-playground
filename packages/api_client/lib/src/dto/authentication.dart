import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class AuthenticationDto {
  AuthenticationDto({
    required this.token,
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  final String token;
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;

  factory AuthenticationDto.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationDtoToJson(this);
}
