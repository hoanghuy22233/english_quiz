// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/Theory/theory_bloc.dart';
import 'package:english_quiz/bloc/Theory_container/theory_container_bloc.dart';
import 'package:english_quiz/bloc/Theory_english/theory_english_bloc.dart';
import 'package:utils_libs/utils_libs.dart' show TrailLoading;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/bloc/blocs.dart';

class WidgetTheoryContainerBloc extends StatelessWidget {
  final Function blocTheory;
  final TheoryContainerBloc? bloc;
  WidgetTheoryContainerBloc({this.bloc, required this.blocTheory});
  @override
  Widget build(BuildContext context) => BlocBuilder<TheoryContainerBloc, TheoryContainerState>(
    bloc: bloc,
    builder: (context, state) {
      if (state is UpdateContainerTheory) {
        return blocTheory(state.theorys);
      } else {
        return TrailLoading(width: 100, height: 100);
      }
    },
  );
}
