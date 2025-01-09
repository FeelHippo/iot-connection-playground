import 'package:json_annotation/json_annotation.dart';

part 'generic_request.g.dart';

@JsonSerializable()
class GenericRequest {
  GenericRequest({
    required this.something,
  });

  factory GenericRequest.fromJson(Map<String, dynamic> json) =>
      _$GenericRequestFromJson(json);

  final String something;

  Map<String, dynamic> toJson() => _$GenericRequestToJson(this);
}
