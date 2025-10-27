import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationInterceptor extends Interceptor {
  static const String _tokenKey = 'token';
  static const String nonAuth = 'no_auth';
  static const Map<String, Object> isNonAuthenticated = <String, Object>{
    nonAuth: true,
  };

  AuthenticationInterceptor({
    required this.secureStorage,
  });

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra.containsKey(nonAuth) && options.extra[nonAuth] == true) {
      handler.next(options);
      return;
    }

    final String? token = await secureStorage.read(key: _tokenKey);

    if (token == null || token.isEmpty) {
      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 401,
        ),
      );
    }

    // TODO: align this with backend, no token verification middleware in place right now
    // options.headers['Authorization'] = 'Bearer $token';
    options.contentType = 'application/json';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // refresh token
    } else if (err.response?.statusCode == 403) {
      // redirect
    }
    super.onError(err, handler);
  }
}
