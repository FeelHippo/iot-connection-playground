import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel(
    this.id,
    this.name,
  );

  final String id;
  final String name;

  @override
  List<Object> get props => <Object>[
        id,
        name,
      ];
}
