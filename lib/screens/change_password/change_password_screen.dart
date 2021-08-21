// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/screens/change_password/index.dart';
import 'package:english_quiz/screens/screens.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            child: Column(
              children: [
                WidgetHeaderBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetContainerImage(
                            height: AppValue.widths*0.7,
                            width: AppValue.widths*0.7,
                            image: IMAGES.LOGO_APP,
                          ),
                          WidgetChangePasswordForm(),
                          AppValue.vSpaceSmall
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        )
      ),
    );
  }
}
