import 'package:flutter/material.dart';
import 'package:utils_libs/utils_libs.dart';
// ignore: import_of_legacy_library_into_null_safe

class WidgetText extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLine;

  WidgetText({this.title, this.style, this.textAlign, this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      textAlign: textAlign ?? textAlign,
      style: style != null ? style : AppStyle.DEFAULT_MEDIUM.copyWith(
        color: COLORS.WHITE,
        fontWeight: FontWeight.bold,
      ),
      maxLines: maxLine,
    );
  }
}