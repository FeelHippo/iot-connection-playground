import 'package:json_annotation/json_annotation.dart';

part 'generic_dto.g.dart';

@JsonSerializable()
class GenericDto {
  GenericDto({
    required this.name,
  });

  final String name;

  factory GenericDto.fromJson(Map<String, dynamic> json) =>
      _$GenericDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GenericDtoToJson(this);
}
