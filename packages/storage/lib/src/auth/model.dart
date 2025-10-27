import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  AuthModel({
    required this.token,
    required this.userUid,
  });

  AuthModel.empty() : token = null, userUid = null;

  bool get isEmpty => token == null && userUid == null;

  final String? token;
  final String? userUid;

  @override
  List<Object?> get props => <Object?>[
    token,
    userUid,
  ];
}
