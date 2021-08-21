// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/widgets/widgets.dart';
import 'package:utils_libs/utils_libs.dart' show AppNavigator, COLORS;
import 'package:flutter/material.dart';

class WidgetBarNew extends StatelessWidget {
  final String? title;
  final String? icon;
  final Color? backgroundColor;
  final List<Widget>? right;
  final GlobalKey<ScaffoldState>? drawerKey;

  WidgetBarNew({this.title, this.icon, this.right, this.backgroundColor, this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return WidgetAppbar(
        textColor: COLORS.WHITE,
        left: [
          WidgetBackButton(
            icon: icon,
              // onTap: drawerKey != null
              //     ? () => drawerKey!.currentState!.openDrawer()
              //     : null,
          ),
        ],
        right: right,
        title: title,
        backgroundColor: backgroundColor
    );
  }
}
