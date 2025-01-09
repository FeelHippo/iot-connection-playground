import 'package:apiClient/main.dart';
import 'package:apiClient/src/dto/generic_dto.dart';
import 'package:apiClient/src/requests/generic_request.dart';
import 'package:apiClient/src/something/mapper.dart';
import 'package:apiClient/src/something/model.dart';
import 'package:retrofit/dio.dart';

import 'provider.dart';

class NetworkInterface extends SomethingProvider {
  NetworkInterface({required this.apiClient, required this.mapper});

  final ApiClient apiClient;
  final SomethingMapper mapper;

  @override
  Future<List<SomethingModel>> getSomething() async {
    final List<GenericDto> response = await apiClient.getSomething();
    return response.map(mapper.map).toList();
  }

  @override
  Future<bool> postSomething(String something) async {
    final HttpResponse<dynamic> response = await apiClient.postSomething(
      GenericRequest(something: something),
    );
    return response.response.statusCode == 201;
  }
}
