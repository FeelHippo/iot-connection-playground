import 'package:apiClient/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static Dio createDio(Injector injector) {
    return DioFactory.create(
      secureStorage: injector.get<FlutterSecureStorage>(),
    );
  }

  static ApiClient createApiClient(Injector injector) => ApiClient(
    injector.get<Dio>(),
  );
}
