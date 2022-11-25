import 'package:dio/dio.dart';
import 'package:paprika/app/constants.dart';
import 'package:retrofit/http.dart';

import '../resonse/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('login')
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST('register')
  Future<AuthenticationResponse> register(
    @Field("email") String email,
    @Field("password") String password,
    @Field("phone") String phone,
    @Field("name") String name,
  );
}
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient2 {
  factory AppServiceClient2(Dio dio, {String baseUrl}) = _AppServiceClient2;

  @POST('login')
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST('register')
  Future<AuthenticationResponse> register(
      @Field("email") String email,
      @Field("password") String password,
      @Field("phone") String phone,
      @Field("name") String name,
      );
}
