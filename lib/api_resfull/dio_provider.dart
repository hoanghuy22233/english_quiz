// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/storages/share_local.dart';
import 'package:utils_libs/utils_libs.dart' show BASE_URL, PreferencesKey;
import 'package:dio/dio.dart' show Dio, LogInterceptor; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv; // ignore: import_of_legacy_library_into_null_safe

class DioProvider {
  static final Dio _dio = Dio();
  static Dio instance({String? token}) {
    _dio
      ..options.baseUrl = DotEnv.env[PreferencesKey.BASE_URL]
      ..options.connectTimeout = BASE_URL.connectionTimeout
      ..options.receiveTimeout = BASE_URL.receiveTimeout
      ..options.headers = {
        BASE_URL.content_type: BASE_URL.application_json,
        BASE_URL.auth_type: "Bearer $token"
      }
      ..options.followRedirects = false
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    return _dio;
  }
}
