import 'package:storage/main.dart';

abstract class AuthProvider {
  Future<Map<String?, String?>> getStoredValues();
  Stream<AuthModel> get();
  Future<void> put(AuthModel model);
  Future<void> update({
    String? name,
    String? accessToken,
    String? refreshToken,
  });
  Future<void> remove();
}
