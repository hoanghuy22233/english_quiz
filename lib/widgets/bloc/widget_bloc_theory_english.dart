// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/Theory_english/theory_english_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart' show TrailLoading;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetTheoryEnglishBloc extends StatelessWidget {
  final Function blocTheory;
  final TheoryEnglishBloc? bloc;
  WidgetTheoryEnglishBloc({this.bloc, required this.blocTheory});
  @override
  Widget build(BuildContext context) => BlocBuilder<TheoryEnglishBloc, TheoryEnglishState>(
    bloc: bloc,
    builder: (context, state) {
      if (state is UpdateTheoryEnglish) {
        return blocTheory(state.theory);
      } else {
        return TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2);
      }
    },
  );
}
