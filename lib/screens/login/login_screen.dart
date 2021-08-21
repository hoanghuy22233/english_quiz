// ignore: import_of_legacy_library_into_null_safe
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:english_quiz/screens/login/index.dart';
import 'package:english_quiz/screens/screens.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(MESSAGES.BACK_TO_EXIT, style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.WHITE),),
        ),
        child: SafeArea(
          child: WidgetTouchHideKeyBoard(
            child: Container(
              height: AppValue.heights,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      const Color(0xFF0983CA),
                      const Color(0xFF79D0FE),
                    ],
                    begin: const FractionalOffset(0.0, 1.0),
                    end: const FractionalOffset(0.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      WidgetContainerImage(
                        height: AppValue.widths*0.7,
                        width: AppValue.widths*0.7,
                        image: IMAGES.LOGO_APP,
                      ),
                      WidgetLoginForm(),
                    ],
                  ),
                ),
              )
            ),
          )
        ),
      ),
    );
  }
}
