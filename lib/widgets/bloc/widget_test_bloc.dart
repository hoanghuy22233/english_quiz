// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/test/test_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart' show TrailLoading;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2);
        }
      },
    );
  }
}
