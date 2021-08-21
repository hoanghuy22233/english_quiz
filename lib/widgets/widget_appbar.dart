import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetAppbar extends StatelessWidget {
  final String? title;
  final List<Widget>? left;
  final List<Widget>? right;
  final Color? textColor, backgroundColor;
  final double height;

  const WidgetAppbar({
    Key? key,
    this.title,
    this.left,
    this.right,
    this.backgroundColor = COLORS.PRIMARY_COLOR,
    this.textColor = COLORS.WHITE,
    this.height = 60
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor
      ),
      child: Stack(
        children: [
          left != null
              ? Positioned.fill(
                  left: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: left!,
                  ),
                )
              : AppValue.kEmptyWidget,
          right != null
              ? Positioned.fill(
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: right!,
                  ),
                )
              : AppValue.kEmptyWidget,
          Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title ?? "",
                        style: AppStyle.DEFAULT_MEDIUM.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
