import 'package:storage/main.dart';

abstract class AuthProvider {
  Stream<AuthModel> get();
  Future<void> put(AuthModel model);
  Future<void> remove();
}
