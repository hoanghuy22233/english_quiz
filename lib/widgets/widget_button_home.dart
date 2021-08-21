import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';

class WidgetButtonHome extends StatelessWidget {
  final VoidCallback onTap;
  final String? text;
  final Color? backgroundColor;
  final double? height, width;
  final bool? enable;
  final Widget? child;

  const WidgetButtonHome({
    Key? key,
    required this.onTap,
    this.text,
    this.backgroundColor = COLORS.PRIMARY_COLOR,
    this.height = 35,
    this.width,
    this.enable = true,
    this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: WidgetContainerCenter(
          width: width ?? AppValue.widths,
          height: height,
          boxDecoration: BoxDecoration(
              color: enable! ? backgroundColor : COLORS.GREY,
              borderRadius: BorderRadius.circular(40)
          ),
          child: child ?? Text(text!, style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.WHITE),
          )),
    );
  }
}
