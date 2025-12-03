import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationInterceptor extends Interceptor {
  static const String _nameKey = 'name_token';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String nonAuth = 'no_auth';
  static const Map<String, Object> isNonAuthenticated = <String, Object>{
    nonAuth: true,
  };

  AuthenticationInterceptor({
    required this.dio,
    required this.secureStorage,
    required this.getStoredValues,
    required this.updateValues,
  });

  final Dio dio;
  final FlutterSecureStorage secureStorage;
  final Future<Map<String?, String?>> Function() getStoredValues;
  final Future<void> Function({
    String? name,
    String? accessToken,
    String? refreshToken,
  })
  updateValues;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra.containsKey(nonAuth) && options.extra[nonAuth] == true) {
      handler.next(options);
      return;
    }

    final String? token = await secureStorage.read(key: _accessTokenKey);

    if (token == null || token.isEmpty) {
      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 401,
        ),
      );
    }

    options.headers['Authorization'] = 'Bearer $token';
    options.contentType = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // refresh token
      final String? name = await secureStorage.read(key: _nameKey);
      final String? refreshToken = await secureStorage.read(
        key: _refreshTokenKey,
      );
      final Response<dynamic> response = await dio.get(
        'token/refresh/$name',
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        await updateValues(
          accessToken: response.data['accessToken'] as String,
          refreshToken: response.data['refreshToken'] as String,
        );
      }
    } else if (err.response?.statusCode == 403) {
      // user has not authorization
      // this will update the authentication subject, and cause a redirection in authWidget to the unauthenticated route
      await updateValues(name: null, accessToken: null, refreshToken: null);
    }
    super.onError(err, handler);
  }
}
