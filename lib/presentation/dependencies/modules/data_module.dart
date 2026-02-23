import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injector/injector.dart';

class DataModule {
  static FlutterSecureStorage createFlutterSecureStorage(Injector injector) =>
      const FlutterSecureStorage();
}
