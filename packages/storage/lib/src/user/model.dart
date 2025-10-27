import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  bool get isEmpty => id.isEmpty;

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
