import 'package:apiClient/src/interceptors/content_type_interceptor.dart';
import 'package:apiClient/src/interceptors/locale_interceptor.dart';
import 'package:apiClient/src/interceptors/os_type_interceptor.dart';
import 'package:apiClient/src/locale/locale_provider.dart';
import 'package:apiClient/src/transformers/response_transformer.dart';
import 'package:dio/dio.dart';

import 'dio_logger.dart';

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

  static Dio create(
    LocaleProvider localeProvider,
  ) {
    final BaseOptions options = BaseOptions(
      baseUrl:
          'http://ec2-16-170-122-157.eu-north-1.compute.amazonaws.com/', // wifi ip from command prompt with Git Bash -> ipconfig
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final Dio dio = Dio()..options = options;

    dio.interceptors.addAll(
      <Interceptor>[
        ContentTypeInterceptor(),
        LocaleInterceptor(localeProvider),
        OSTypeInterceptor(),
        DioLogger(
          requestBody: true,
          requestHeader: true,
          compact: false,
        ),
      ],
    );

    dio.transformer = ResponseTransformer();

    return dio;
  }
}
