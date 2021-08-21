// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/Theory/theory_bloc.dart';
import 'package:utils_libs/utils_libs.dart' show TrailLoading;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/bloc/blocs.dart';

class WidgetTheoryBloc extends StatelessWidget {
  final Function blocTheory;
  final TheoryBloc? bloc;
  WidgetTheoryBloc({this.bloc, required this.blocTheory});
  @override
  Widget build(BuildContext context) => BlocBuilder<TheoryBloc, TheoryState>(
    bloc: bloc,
    builder: (context, state) {
      if (state is UpdateTheory) {
        return blocTheory(state.theory);
      } else {
        return TrailLoading(width: 100, height: 100);
      }
    },
  );
}
