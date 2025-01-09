import 'package:apiClient/src/requests/generic_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/generic_dto.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET('something')
  Future<List<GenericDto>> getSomething();

  @POST('something')
  Future<HttpResponse<dynamic>> postSomething(
    @Body() GenericRequest request,
  );
}
