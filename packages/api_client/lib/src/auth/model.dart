class AuthModel {
  AuthModel({required this.token});

  AuthModel.empty() : this(token: '');
  final String token;

  bool get isEmpty => token.isEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthModel &&
          runtimeType == other.runtimeType &&
          token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() {
    return 'AuthModel{token: $token}';
  }
}
