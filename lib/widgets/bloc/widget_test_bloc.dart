// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/Theory/theory_bloc.dart';
import 'package:english_quiz/bloc/test/test_bloc.dart';
import 'package:utils_libs/utils_libs.dart' show TrailLoading;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/bloc/blocs.dart';

class WidgetTestsBloc extends StatelessWidget {
  final Function blocTest;
  final TestsBloc? bloc;
  WidgetTestsBloc({this.bloc, required this.blocTest});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestsBloc, TestsState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is UpdateTestState) {
          return blocTest(state.test);
        }else {
          return TrailLoading(width: 100, height: 100);
        }
      },
    );
  }
}
