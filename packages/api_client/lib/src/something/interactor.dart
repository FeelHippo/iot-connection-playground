import 'package:apiClient/main.dart';

class SomethingInteractor {
  SomethingInteractor({required this.provider});

  final SomethingProvider provider;

  Future<List<SomethingModel>> getSomething() async {
    return provider.getSomething();
  }

  Future<bool> postSomething(String something) async {
    return provider.postSomething(something);
  }
}
