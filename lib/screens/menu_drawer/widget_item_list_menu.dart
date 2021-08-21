// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart' show AppStyle, AppValue, COLORS;
import 'package:flutter/material.dart';

class WidgetItemListMenu extends StatelessWidget {
  final String? icon, title;
  WidgetItemListMenu({this.icon, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon != '' ? Image.asset(
              icon!,
              width: 20,
              height: 20,
              color: COLORS.WHITE,
            ) : Container(),
            AppValue.hSpaceTiny,
            Text(
              title!,
              style: AppStyle.DEFAULT_SMALLs,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: 1,
        )
      ],
    );
  }
}
