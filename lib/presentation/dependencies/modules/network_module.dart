import 'package:apiClient/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class NetworkModule {
  static Dio createDio(Injector injector) {
    return DioFactory.create(
      secureStorage: injector.get<FlutterSecureStorage>(),
      // TODO(Filippo): not happy about this, decouple if possible
      getStoredValues: injector.get<AuthRepository>().getStoredValues,
      updateValues:
          ({String? name, String? accessToken, String? refreshToken}) =>
              injector.get<AuthRepository>().updateValues(
                name: name,
                accessToken: accessToken,
                refreshToken: refreshToken,
              ),
    );
  }

  static ApiClient createApiClient(Injector injector) =>
      ApiClient(injector.get<Dio>());
}
