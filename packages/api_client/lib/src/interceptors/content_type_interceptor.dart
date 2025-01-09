import 'package:dio/dio.dart';

class ContentTypeInterceptor extends Interceptor {
  static const String googlePlaceApi = 'google_place_api';
  static const Map<String, Object> isGooglePlaceApi = <String, Object>{
    googlePlaceApi: true,
  };

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra.containsKey(googlePlaceApi)) {
      handler.next(options);
      return;
    }
    options.contentType = 'application/json';
    handler.next(options);
  }
}
