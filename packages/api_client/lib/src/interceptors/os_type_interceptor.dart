import 'dart:io';

import 'package:dio/dio.dart';

class OSTypeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final Map<String, dynamic> headers =
        Map<String, dynamic>.from(options.headers);
    headers['X-M2H-OS-Type'] = Platform.isAndroid ? 'android' : 'ios';
    options.headers = headers;
    handler.next(options);
  }
}
