import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserDto {
  UserDto({
    required this.user,
  });

  final UserDataDto user;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

@JsonSerializable()
class UserDataDto {
  UserDataDto({
    required this.email,
    required this.username,
    this.telephone,
    this.picture,
  });

  final String email;
  final String username;
  final String? telephone;
  final Uri? picture;

  factory UserDataDto.fromJson(Map<String, dynamic> json) =>
      _$UserDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataDtoToJson(this);
}
