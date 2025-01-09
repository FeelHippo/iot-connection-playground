import 'package:apiClient/src/something/model.dart';

abstract class SomethingProvider {
  Future<List<SomethingModel>> getSomething();
  Future<bool> postSomething(String something);
}
