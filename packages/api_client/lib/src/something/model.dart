import 'package:equatable/equatable.dart';

class SomethingModel extends Equatable {
  const SomethingModel({
    required this.something,
  });

  final String something;

  @override
  List<Object> get props => <Object>[something];
}
