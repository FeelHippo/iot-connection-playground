import 'package:apiClient/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static const Duration _defaultMaxAge = Duration(hours: 1);
  static const Duration _defaultMaxStale = Duration(days: 1);

  static const Map<String, Object> defaultCacheOptions = <String, Object>{
    // If getting data from network fails or no network available,
    // try get data from cache instead of an error.
    'DIO_CACHE_KEY_FORCE_REFRESH': true,
    'DIO_CACHE_KEY_TRY_CACHE': true,
    'DIO_CACHE_KEY_MAX_AGE': _defaultMaxAge,
    'DIO_CACHE_KEY_MAX_STALE': _defaultMaxStale,
  };

  static Dio create({
    required FlutterSecureStorage secureStorage,
  }) {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://e24a4994ed7f.ngrok-free.app/',
      // wifi ip from command prompt with Git Bash -> ipconfig
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final Dio dio = Dio()..options = options;

    dio.interceptors.addAll(
      <Interceptor>[
        AuthenticationInterceptor(
          secureStorage: secureStorage,
        ),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      ],
    );

    return dio;
  }
}
