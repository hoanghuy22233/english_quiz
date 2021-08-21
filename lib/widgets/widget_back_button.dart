// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/widgets/widgets.dart';
import 'package:utils_libs/utils_libs.dart' show AppNavigator, ICONS;
import 'package:flutter/material.dart';

class WidgetBackButton extends StatelessWidget {
  final Function? onTap;
  final Color? color;
  final String? icon;
  final double? width, height;
  const WidgetBackButton({
    Key? key,
    this.onTap,
    this.color,
    this.icon,
    this.width,
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: width ?? 40,
        width: height ?? 40,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: WidgetAppbarMenu(
          isIcon: icon ?? ICONS.ICON_BACK,
          icon: Image.asset(icon ?? ICONS.ICON_BACK, fit: BoxFit.fill, color: color),
          onTap: onTap ?? () => AppNavigator.navigateBack(),
        )
    );
  }
}
