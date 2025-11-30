import 'package:equatable/equatable.dart';

class RegistrationStartModel extends Equatable {
  RegistrationStartModel({
    required this.challenge,
    required this.rp,
    required this.user,
    required this.excludeCredentials,
  });

  final String challenge;
  final RelyingPartyModel rp;
  final UserModel user;
  final List<dynamic> excludeCredentials;

  @override
  List<Object> get props => <Object>[
    challenge,
    rp,
    user,
    excludeCredentials,
  ];
}

class RelyingPartyModel extends Equatable {
  RelyingPartyModel({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  @override
  List<Object> get props => <Object>[id, name];
}

class UserModel extends Equatable {
  UserModel({
    required this.id,
    required this.name,
    required this.displayName,
  });
  final String id;
  final String name;
  final String displayName;

  @override
  List<Object> get props => <Object>[id, name, displayName];
}
