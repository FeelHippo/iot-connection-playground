import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });
  final String? accessToken;
  final String? refreshToken;

  bool get isEmpty => accessToken == null && refreshToken == null;

  AuthModel.empty() : accessToken = null, refreshToken = null;

  @override
  List<Object?> get props => <Object?>[accessToken, refreshToken];
}
