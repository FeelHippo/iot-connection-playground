import 'package:equatable/equatable.dart';

class AuthenticationModel extends Equatable {
  AuthenticationModel({
    required this.name,
    required this.accessToken,
    required this.refreshToken,
  });
  final String name;
  final String accessToken;
  final String refreshToken;

  @override
  List<Object> get props => <Object>[
    name,
    accessToken,
    refreshToken,
  ];
}
