import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  UserDataModel({
    required this.username,
    required this.telephone,
    this.picture,
  });

  final String username;
  final String? telephone;
  final Uri? picture;

  bool get needsMoreData =>
      telephone == null || telephone!.isEmpty || picture == null;

  @override
  List<Object?> get props => <Object?>[
    username,
    telephone,
    picture,
  ];
}
