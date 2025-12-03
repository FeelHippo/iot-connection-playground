import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class AuthenticationDto {
  AuthenticationDto({
    required this.name,
    required this.accessToken,
    required this.refreshToken,
  });

  final String name;
  final String accessToken;
  final String refreshToken;

  factory AuthenticationDto.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationDtoToJson(this);
}
