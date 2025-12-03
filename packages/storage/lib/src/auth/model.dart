import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  AuthModel({
    required this.name,
    required this.accessToken,
    required this.refreshToken,
  });
  final String? name;
  final String? accessToken;
  final String? refreshToken;

  bool get isEmpty => <String?>[
    name,
    accessToken,
    refreshToken,
  ].every((String? property) => property == null);

  AuthModel.empty() : name = null, accessToken = null, refreshToken = null;

  @override
  List<Object?> get props => <Object?>[
    name,
    accessToken,
    refreshToken,
  ];
}
