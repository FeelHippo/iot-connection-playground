import 'package:json_annotation/json_annotation.dart';

part 'login_start.g.dart';

@JsonSerializable()
class LoginStartDto {
  LoginStartDto({
    required this.challenge,
    required this.rpId,
  });

  final String challenge;
  final String rpId;

  factory LoginStartDto.fromJson(Map<String, dynamic> json) =>
      _$LoginStartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStartDtoToJson(this);
}
