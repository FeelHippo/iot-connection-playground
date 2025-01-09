import 'dart:convert';

import 'package:apiClient/main.dart';
import 'package:storage/main.dart';
import 'package:synchronized/synchronized.dart';

class StoreUserProvider extends UserProvider {
  StoreUserProvider(this.network, this.userPreferences);

  final NetworkUserStorage network;
  final Lock _lock = Lock();
  final UserPreferences userPreferences;

  @override
  Future<UserModel?> get(String id, {bool refresh = false}) async {
    if (id.isEmpty) {
      return null;
    }

    return _lock.synchronized(() async {
      UserModel? user;
      if (refresh) {
        user = await network.get(id);
        if (user != null) {
          await userPreferences.putString(
              key: StoreUserPreferences.prefLoginUserData,
              value: jsonEncode(user)); // TODO(Filippo): TBD
        }
      } else {
        final String data = await userPreferences.getString(
          key: StoreUserPreferences.prefLoginUserData,
        );
        if (data.isEmpty) {
          user = await network.get(id);
          if (user != null) {
            await userPreferences.putString(
              key: StoreUserPreferences.prefLoginUserData,
              value: jsonEncode(user), // TODO(Filippo): TBD
            );
          }
        } else {
          user = UserModel('id', 'name'); // TODO(Filippo): TBD
        }
      }
      return user;
    });
  }
}

abstract class UserStorage {
  Future<UserModel?> get(String id);

  Future<DateTime> getCurrentUserCreationDate(String token);
}
