// ignore: camel_case_types
class BASE_URL {
  BASE_URL._();
  //GET
  static const GET_INFO_USER = 'api/profile';
  static const NOTIFICATION = 'api/notifications';
  static const POST = 'api/post';
  static const THEORY = 'api/documents';
  static const TESTS = 'api/exams';

  //POST
  static const LOGIN = 'api/login';
  static const PROFILE = 'api/profile';
  static const CHANGE_PASSWORD = 'api/change-password';
  static const RESET_PASSWORD = 'api/reset-password';
  static const FORGOT_PASSWORD = 'api/forgot-password';
  static const SEEN_UPDATE = 'api/notifications/status';
  static const RESULT ='api/result';
  static const STATISTICS ='api/statistics';

  // receiveTimeout
  static const int receiveTimeout = 15000;

  static const ENV  = 'assets/.env';

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const content_type = 'Content-Type';
  static const application_json = 'application/json';
  ////////////////////////////////////////////////////////
  static const multipart_form_data = 'multipart/form-data';

  static const auth_type = 'Authorization';
  ////////////////////////////////////////////////////////
  static String bearer(String token) => token;

  static const headerDemoKey = 'Demo-Header';
  static const headerDemoValue = 'demo header';

  static const SUCCESS = true;
  static const FAIL = false;

  static const ACTIVE = 1;
  static const LOCK = 0;
}
