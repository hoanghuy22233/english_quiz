import 'package:english_quiz/storages/share_local.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv; // ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart' show Dio; // ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/api_resfull/api.dart';
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class UserRepository {
  Dio dio = Dio();
  final _controller = StreamController<AuthenticationStatus>();
  final _controllerUser = StreamController<DataUser>();
  UserRepository(){
    statusUser.listen((event) {
      if(event.token == DotEnv.env[PreferencesKey.TOKEN]!){
        dio = DioProvider.instance();
      }else{
        // dio = DioProvider.instance(token: event.token);
        dio = DioProvider.instance(token: shareLocal.getString(PreferencesKey.TOKEN));
      }
    });
  }

  //==========================================> GET <=========================================

  Future<ResponseStatus> getInfoUser() async => await RestClient(dio, baseUrl: dio.options.baseUrl).getInfoUser();

  Future<ResponseTheoryStatus> getTheory({required int type}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).getTheory(type);
  Future<ResponseTests> getTest({required int type}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).getTest(type);

  Future<ResponseDetailQuestion> getDetailQuestion({required int id}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).getDetailQuestion(id);

  Future<ResponseTheoryDeatilStatuss> getDetailTheory({required int id}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).getDetailTheory(id);

  Future<NotificationResponseStatus> getNotification() async => await RestClient(dio, baseUrl: dio.options.baseUrl).getNotification();

  Future<NotificationDetailResponseStatus> getDetailNotification({required int id}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).getDetailNotification(id);

  Future<NotificationSeenResponseStatus> seenNotification({required int id}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).seenNotification(id);

  Future<ResponsePostStatus> getPost({required int type}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).getPost(type);

  Future<ResponseStatisticsData> getStatistics() async => await RestClient(dio, baseUrl: dio.options.baseUrl).getStatistics();

  Future<ResponsePostResultStatus> getDetailStatistics({required int id}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).getDetailStatistics(id);

  //=========================================> POST <=========================================

  Future<UserResponse> loginApp({required String code, required String password, required String deviceCode}) async =>
      await RestClient(dio, baseUrl: dio.options.baseUrl).loginApp(LoginAppRequest(code: code, password: password, deviceCode: deviceCode));

  Future<ResponseStatus> changePassword({required ParamChangePassword paramChangePassword}) async =>
      await RestClient(dio, baseUrl: dio.options.baseUrl).changePassword(paramChangePassword);

  Future<ResponseStatus> forgotPassword({required ParamForgotPassword paramForgotPassword}) async =>
      await RestClient(dio, baseUrl: dio.options.baseUrl).forgotPassword(paramForgotPassword);

  Future<ResponseStatus> resetPassword({required ParamResetPassword paramResetPassword}) async =>
      await RestClient(dio, baseUrl: dio.options.baseUrl).resetPassword(paramResetPassword);

  Future<ResponseStatus> postUpdateProfile({required InfoUser infoUser}) async =>
      await RestClient(dio, baseUrl: dio.options.baseUrl).postUpdateProfile(infoUser);

  Future<ResponseDataStatus> postImage({required File file, required String code, required List<dynamic> type, required String email, required String name}) async =>
      await RestClient(dio, baseUrl: dio.options.baseUrl).postImages(image: file, code: code, type: type, email: email, name: name);

  Future<ResponsePostResultStatus> postResult({required int id, required int idQ}) async => await RestClient(dio, baseUrl: dio.options.baseUrl).postResult(id,idQ);

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Stream<DataUser> get statusUser async* {
    yield* _controllerUser.stream;
  }

  void logOut() => _controller.add(AuthenticationStatus.unauthenticated);

  void addUser(DataUser user) => _controllerUser.add(user);

  void dispose(){
    _controllerUser.close();
    _controller.close();
  }
}