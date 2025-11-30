import 'package:equatable/equatable.dart';

class AuthenticationModel extends Equatable {
  AuthenticationModel({
    required this.accessToken,
    required this.refreshToken,
  });
  final String accessToken;
  final String refreshToken;

  @override
  List<Object> get props => <Object>[accessToken, refreshToken];
}
