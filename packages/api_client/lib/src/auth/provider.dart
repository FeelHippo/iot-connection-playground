import 'package:apiClient/src/auth/model.dart';

abstract class AuthProvider {
  /// lib/data/auth/store_auth_provider.dart
  /// returns the broadcast StreamController
  /// that caches the latest added value or error
  Stream<AuthModel> get();

  /// lib/data/auth/store_auth_provider.dart
  /// if the model is empty, remove the token from storage
  /// otherwise, write the new token to storage
  Future<void> put(AuthModel model);

  /// lib/data/auth/store_auth_provider.dart
  /// remove authentication from app storage
  Future<void> remove();
}
