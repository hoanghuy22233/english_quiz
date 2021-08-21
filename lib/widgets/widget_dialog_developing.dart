import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'package:english_quiz/widgets/widgets.dart';

class WidgetDialogDeveloping extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WidgetDialog(
      title: MESSAGES.NOTIFICATION,
      content: MESSAGES.DEVELOPING,
      onTap1: () => AppNavigator.navigateBack(),
    );
  }
}