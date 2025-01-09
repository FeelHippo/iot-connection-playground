import 'package:equatable/equatable.dart';

/// Class LoginModel
class LoginModel extends Equatable {
  /// Default Constructor
  const LoginModel({required this.token});

  /// token
  final String token;

  @override
  List<Object> get props => <Object>[token];
}
