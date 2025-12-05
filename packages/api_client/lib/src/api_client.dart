import 'package:apiClient/main.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @Extra(<String, Object>{
    AuthenticationInterceptor.nonAuth: true,
  })
  @POST('register/start')
  Future<RegistrationStartDto> registerStart(
    @Body() RegisterStartRequest request,
  );

  @Extra(<String, Object>{
    AuthenticationInterceptor.nonAuth: true,
  })
  @POST('register/finish')
  Future<AuthenticationDto> registerFinish(
    @Body() RegisterFinishRequest request,
  );

  @Extra(<String, Object>{
    AuthenticationInterceptor.nonAuth: true,
  })
  @POST('login/start')
  Future<LoginStartDto> loginStart(
    @Body() LoginStartRequest request,
  );

  @Extra(<String, Object>{
    AuthenticationInterceptor.nonAuth: true,
  })
  @POST('login/finish')
  Future<AuthenticationDto> loginFinish(
    @Body() LoginFinishRequest request,
  );
  @GET('user/data')
  Future<UserDto> getUserData();
  @PATCH('user/data')
  Future<UserDto> modifyUserData(
    // TODO: to make sure the keys are all valid, use asnameMap() in the apiClient
    // https://api.flutter.dev/flutter/dart-core/EnumByName/asNameMap.html
    @Body() List<Map<String, dynamic>> request,
  );
}
