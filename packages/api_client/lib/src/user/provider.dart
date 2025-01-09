import 'package:apiClient/src/user/model.dart';

abstract class UserProvider {
  Future<UserModel?> get(String id, {bool refresh});
}
