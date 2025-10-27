import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injector/injector.dart';

class AppModule {
  static Connectivity createConnectivity(Injector injector) => Connectivity();
}
