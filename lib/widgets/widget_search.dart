// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/widgets/widget_input.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return WidgetInput(
      hint: MESSAGES.SEARCH_POST,
      endIcon: Icon(Icons.search),

    );
  }
}
