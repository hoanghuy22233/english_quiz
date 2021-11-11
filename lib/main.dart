// @dart=2.9
import 'dart:async';
import 'package:english_quiz/bloc/Statistics/statistics_bloc.dart';
import 'package:english_quiz/bloc/Theory/theory_bloc.dart';
import 'package:english_quiz/bloc/Theory_container/theory_container_bloc.dart';
import 'package:english_quiz/bloc/Theory_english/theory_english_bloc.dart';
import 'package:english_quiz/bloc/detail_question/detail_question_bloc.dart';
import 'package:english_quiz/bloc/result/result_bloc.dart';
import 'package:english_quiz/bloc/statistics_detail/statistics_detail_bloc.dart';
import 'package:english_quiz/bloc/test/test_bloc.dart';
import 'package:english_quiz/screens/english/english_screen.dart';
import 'package:english_quiz/screens/english/english_test/english_test_screen.dart';
import 'package:english_quiz/screens/english/theory_english/english_theory_screen.dart';
import 'package:english_quiz/screens/knowledge/Knowledge_money/knowledge_money_screen.dart';
import 'package:english_quiz/screens/knowledge/Knowledge_money/knowledge_money_test_screen.dart';
import 'package:english_quiz/screens/knowledge/knowledge_screen.dart';
import 'package:english_quiz/screens/knowledge/knowledge_test/knowledge_test_screen.dart';
import 'package:english_quiz/screens/knowledge/theory_knowledge/knowledge_theory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:get/get.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:english_quiz/screens/screens.dart';
import 'package:english_quiz/storages/storages.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'api_resfull/api.dart';
import 'bloc/blocs.dart';
import 'bloc/simple_bloc_observer.dart';
import 'screens/knowledge/Knowledge_money/knowledge_activity_money_screen.dart';

Future main() async {
  Bloc.observer = SimpleBlocObserver();
  await DotEnv.load(fileName: BASE_URL.ENV);
  shareLocal = await ShareLocal.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
  UserRepository userRepository = UserRepository();
  runApp(
      MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
            localRepository: const EventRepositoryStorage(),
          )..add(AuthenticationStateInit()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: userRepository,
              localRepository: const EventRepositoryStorage(),
            ),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => ChangePasswordBloc(
              userRepository: userRepository,
            ),
          ),
          BlocProvider<ForgotPasswordBloc>(
            create: (context) => ForgotPasswordBloc(
              userRepository: userRepository,
            ),
          ),
          BlocProvider<ResetPasswordBloc>(
            create: (context) => ResetPasswordBloc(
              userRepository: userRepository,
            ),
          ),
          BlocProvider<ResendOTPBloc>(
            create: (context) => ResendOTPBloc(
              userRepository: userRepository,
            ),
          ),
          BlocProvider<InfoUserBloc>(
            create: (context) => InfoUserBloc(
              userRepository: userRepository,
              localRepository: const EventRepositoryStorage(),
              context: context
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              userRepository: userRepository,
              blocInfo: BlocProvider.of<InfoUserBloc>(context),
            ),
          ),
          BlocProvider<UserNotificationBloc>(
            create: (context) => UserNotificationBloc(userRepository: userRepository),
          ),
          BlocProvider<TheoryBloc>(
            create: (context) => TheoryBloc(userRepository: userRepository),
          ),

          BlocProvider<TheoryContainerBloc>(
            create: (context) => TheoryContainerBloc(userRepository: userRepository),
          ),

          BlocProvider<TheoryEnglishBloc>(
            create: (context) => TheoryEnglishBloc(userRepository: userRepository),
          ),
          BlocProvider<TestsBloc>(
            create: (context) => TestsBloc(userRepository: userRepository),
          ),
          BlocProvider<DetailQuestionsBloc>(
            create: (context) => DetailQuestionsBloc(userRepository: userRepository),
          ),
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(userRepository: userRepository),
          ),
          BlocProvider<ResultBloc>(
            create: (context) => ResultBloc(userRepository: userRepository),
          ),
          BlocProvider<StatisticsBloc>(
            create: (context) => StatisticsBloc(userRepository: userRepository),
          ),

          BlocProvider<StatisticsDetailBloc>(
            create: (context) => StatisticsDetailBloc(userRepository: userRepository),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: COLORS.PRIMARY_COLOR, // status bar color
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      title: MESSAGES.APP_TITLE,
      initialRoute: ROUTE_NAMES.SPLASH,
      getPages: [
        GetPage(
          name: ROUTE_NAMES.MAIN,
          page: () => MainScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.SPLASH,
          page: () => SplashPage(),
        ),
        GetPage(
          name: ROUTE_NAMES.LOGIN,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.FORGOT_PASSWORD,
          page: () => ForgotPasswordScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.FORGOT_PASSWORD_RESET,
          page: () => ForgotPasswordResetScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.CHANGE_PASSWORD,
          page: () => ChangePasswordScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.INFORMATION_ACCOUNT,
          page: () => AccountInformation(),
        ),
        GetPage(
          name: ROUTE_NAMES.KNOWLEDGE,
          page: () => KnowledgeScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.ENGLISH,
          page: () => EnglishScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.TEST_CHOOSE_TEST,
          page: () => EnglishTestScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.TEST_CHOOSE_THEORY,
          page: () => EnglishTheoryScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.KNOWLEDGE_CHOOSE_THEORY,
          page: () => KnowledgeTheoryScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.KNOWLEDGE_CHOOSE_TEST,
          page: () => KnowledgeTestScreen(),
        ),

        GetPage(
          name: ROUTE_NAMES.KNOWLEDGE_MONEY,
          page: () => KnowMoneyScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES. KNOWLEDGE_MONEY_TEST,
          page: () => KnowledgeMoneyTestScreen(),
        ),

        GetPage(
          name: ROUTE_NAMES. KNOWLEDGE_MONEY_ACTIVITY,
          page: () => KnowledgeActivityMoneyScreen(),
        ),



        GetPage(
          name: ROUTE_NAMES.CHANGE_INFORMATION_ACCOUNT,
          page: () => ChangeAccountInformation(),
        ),
        GetPage(
          name: ROUTE_NAMES.MANUAL,
          page: () => ManualScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.NOTIFICATION,
          page: () => NotificationScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.DETAIL_NOTIFICATION,
          page: () => NotificationDetailScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.POLICY,
          page: () => PolicyScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.STATISTICAL,
          page: () => StatisticalScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.ABOUT_US,
          page: () => AboutUsScreen(),
        ),
        GetPage(
          name: ROUTE_NAMES.STATISTICAL_RESULT_ITEM,
          page: () => StatisticalResultItem(),
        ),

      ],
    );
  }
}
