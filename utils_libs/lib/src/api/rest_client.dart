import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:utils_libs/src/models/model_generator/response_test.dart';
import 'package:utils_libs/src/models/model_generator/response_theory.dart';
import 'package:utils_libs/utils_libs.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: "https://onthicongchuc.net/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  // =================================> GET <===================================

  @GET(BASE_URL.GET_INFO_USER)
  Future<ResponseStatus> getInfoUser();

  @GET(BASE_URL.THEORY)
  Future<ResponseTheoryStatus> getTheory(@Query('type') int type);

  @GET(BASE_URL.THEORY + "/{id}")
  Future<ResponseTheoryDeatilStatuss> getDetailTheory(@Path("id") int id);

  @GET(BASE_URL.NOTIFICATION)
  Future<NotificationResponseStatus> getNotification();

  @GET(BASE_URL.NOTIFICATION + "/{id}")
  Future<NotificationDetailResponseStatus> getDetailNotification(@Path("id") int id);

  @GET(BASE_URL.POST + "/{type}")
  Future<ResponsePostStatus> getPost(@Path("type") int type);

  @GET(BASE_URL.TESTS)
  Future<ResponseTests> getTest(@Query('type') int type);

  @GET(BASE_URL.TESTS + "/{id}")
  Future<ResponseDetailQuestion> getDetailQuestion(@Path("id") int id);

  @GET(BASE_URL.STATISTICS)
  Future<ResponseStatisticsData> getStatistics();

  @GET(BASE_URL.STATISTICS + "/{id}")
  Future<ResponsePostResultStatus> getDetailStatistics(@Path("id") int id);

  // =================================> POST <==================================
  @POST(BASE_URL.LOGIN)
  Future<UserResponse> loginApp(@Body() LoginAppRequest loginAppRequest);

  @POST(BASE_URL.CHANGE_PASSWORD)
  Future<ResponseStatus> changePassword(@Body() ParamChangePassword paramChangePassword);

  @POST(BASE_URL.FORGOT_PASSWORD)
  Future<ResponseStatus> forgotPassword(@Body() ParamForgotPassword paramForgotPassword);

  @POST(BASE_URL.RESET_PASSWORD)
  Future<ResponseStatus> resetPassword(@Body() ParamResetPassword paramResetPassword);

  @POST(BASE_URL.PROFILE)
  Future<ResponseStatus> postUpdateProfile(@Body() InfoUser infoUser);

  @POST(BASE_URL.PROFILE)
  Future<ResponseDataStatus> postImages({@Part() File image, @Query('code') String code, @Query('type') int type, @Query('email') String email, @Query('name') String name});

  @POST(BASE_URL.SEEN_UPDATE + "/{id}")
  Future<NotificationSeenResponseStatus> seenNotification(@Path("id") int id);

  @POST(BASE_URL.RESULT + "/{id}")
  Future<ResponsePostResultStatus> postResult(@Path("id") int id,@Query("total_correct") int total);


}
