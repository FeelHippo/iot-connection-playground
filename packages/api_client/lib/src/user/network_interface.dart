import 'package:apiClient/main.dart';

abstract class UserStorage {
  Future<UserModel?> get(String id);
}

class NetworkUserStorage extends UserStorage {
  NetworkUserStorage(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<UserModel?> get(String id) async {
    // TODO(Filippo): TBD
    return null;
  }
}
