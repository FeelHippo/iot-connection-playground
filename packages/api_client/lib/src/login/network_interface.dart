import 'package:apiClient/main.dart';

class NetworkLoginProvider extends LoginProvider {
  NetworkLoginProvider({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<String> getCurrentUserId(String token) async {
    // TODO(Filippo): TBD
    return '';
  }

  @override
  Future<LoginModel> doLogin({required LoginRequest loginRequest}) async {
    // TODO(Filippo): TBD
    return LoginModel(token: '');
  }

  @override
  Future<UserModel> getCurrentUser({required String token}) async {
    // TODO(Filippo): TBD
    return UserModel('', '');
  }
}
