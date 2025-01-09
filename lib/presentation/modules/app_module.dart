import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injector/injector.dart';

class AppModule {
  static DefaultCacheManager createDefaultCacheManager(Injector injector) =>
      DefaultCacheManager();

  static Connectivity createConnectivity(Injector injector) => Connectivity();
}
