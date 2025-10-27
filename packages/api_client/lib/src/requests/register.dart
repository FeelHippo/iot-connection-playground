import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.isAdmin = false,
  });

  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  @JsonKey(defaultValue: false)
  final bool? isAdmin;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
