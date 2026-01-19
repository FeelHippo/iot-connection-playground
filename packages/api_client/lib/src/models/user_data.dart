import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  const UserDataModel({
    required this.id,
    required this.name,
    required this.username,
    this.telephone,
    this.picture,
  });

  final String id;
  final String name;
  final String username;
  final String? telephone;
  final Uri? picture;

  bool get needsMoreData =>
      telephone == null || telephone!.isEmpty || picture == null;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    username,
    telephone,
    picture,
  ];
}
