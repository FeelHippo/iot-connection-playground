import 'package:apiClient/src/locale/locale_provider.dart';
import 'package:dio/dio.dart';

class LocaleInterceptor extends Interceptor {
  LocaleInterceptor(this._localeProvider);
  final LocaleProvider _localeProvider;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept-Language'] = await _localeProvider.currentLocale();
    handler.next(options);
  }
}
