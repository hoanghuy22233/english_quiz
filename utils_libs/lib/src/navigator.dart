import 'package:get/get.dart';
import 'package:utils_libs/src/router.dart';
import 'package:utils_libs/utils_libs.dart';

class AppNavigator {
  AppNavigator._();

  static navigateBack() async => Get.back();

  static navigateSplash() async => await Get.toNamed(ROUTE_NAMES.SPLASH);

  static navigateLogin() async => await Get.toNamed(ROUTE_NAMES.LOGIN);

  static navigateLogout() async => await Get.offAllNamed(ROUTE_NAMES.LOGIN);

  static navigateMain() async => await Get.offAllNamed(ROUTE_NAMES.MAIN);

  static navigateForgotPassword() async => await Get.toNamed(ROUTE_NAMES.FORGOT_PASSWORD);

  static navigateForgotPasswordReset(email) async => await Get.toNamed(ROUTE_NAMES.FORGOT_PASSWORD_RESET, arguments: email);

  static navigateChangePassword() async => await Get.toNamed(ROUTE_NAMES.CHANGE_PASSWORD);

  static navigateInformationAccount() async => await Get.toNamed(ROUTE_NAMES.INFORMATION_ACCOUNT);
  static navigateEnglish() async => await Get.toNamed(ROUTE_NAMES.ENGLISH);

  static navigateKnowledge() async => await Get.toNamed(ROUTE_NAMES.KNOWLEDGE);

  static navigateKnowledgeMoney() async => await Get.toNamed(ROUTE_NAMES.KNOWLEDGE_MONEY);

  static navigateTestMoney() async => await Get.toNamed(ROUTE_NAMES.KNOWLEDGE_MONEY_TEST);

  static navigateTestMoneyActivity() async => await Get.toNamed(ROUTE_NAMES.KNOWLEDGE_MONEY_ACTIVITY);

  static navigateEnglishTheory() async => await Get.toNamed(ROUTE_NAMES.TEST_CHOOSE_THEORY);

  static navigateEnglishTest() async => await Get.toNamed(ROUTE_NAMES.TEST_CHOOSE_TEST);
  static navigateKnowledgeTheory() async => await Get.toNamed(ROUTE_NAMES.KNOWLEDGE_CHOOSE_THEORY);

  static navigateKnowledgeTest() async => await Get.toNamed(ROUTE_NAMES.KNOWLEDGE_CHOOSE_TEST);

  static navigateTestDetail() async => await Get.toNamed(ROUTE_NAMES.TEST_DETAIL);



  static navigateChangeInformationAccount(arguments) async => await Get.toNamed(ROUTE_NAMES.CHANGE_INFORMATION_ACCOUNT, arguments: arguments);

  static navigateManual() async => await Get.toNamed(ROUTE_NAMES.MANUAL);

  static navigateNotification() async => await Get.toNamed(ROUTE_NAMES.NOTIFICATION);

  static navigatePolicy() async => await Get.toNamed(ROUTE_NAMES.POLICY);

  static navigateStatistical() async => await Get.toNamed(ROUTE_NAMES.STATISTICAL);

  static navigateDetailNotification(arguments) async => await Get.toNamed(ROUTE_NAMES.DETAIL_NOTIFICATION, arguments: arguments);

  static navigateAboutUs() async => await Get.toNamed(ROUTE_NAMES.ABOUT_US);

  static navigateStatisticalResultItem({numberQuestions, correctAnswers, wrongAnswers}) async => await Get.toNamed(ROUTE_NAMES.STATISTICAL_RESULT_ITEM, arguments: [numberQuestions, correctAnswers, wrongAnswers]);
}
