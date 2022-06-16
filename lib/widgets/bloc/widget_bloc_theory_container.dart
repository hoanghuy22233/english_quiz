// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/Theory_container/theory_container_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart' show TrailLoading;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2);
      }
    },
  );
}
