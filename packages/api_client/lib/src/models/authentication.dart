import 'package:equatable/equatable.dart';

class BaseAuthModel extends Equatable {
  BaseAuthModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;

  @override
  List<Object> get props => <Object>[
    id,
    email,
    username,
    firstName,
    lastName,
  ];
}

class AuthenticationModel extends BaseAuthModel {
  AuthenticationModel({
    required this.token,
    required super.id,
    required super.email,
    required super.username,
    required super.firstName,
    required super.lastName,
  });

  final String token;

  @override
  List<Object> get props => <Object>[
    token,
  ];
}
