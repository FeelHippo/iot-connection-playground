import 'package:equatable/equatable.dart';

class LoginStartModel extends Equatable {
  LoginStartModel({
    required this.challenge,
    required this.rpId,
  });

  final String challenge;
  final String rpId;

  @override
  List<Object> get props => <Object>[
    challenge,
    rpId,
  ];
}
