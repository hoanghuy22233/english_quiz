// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/blocs.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetBlocInfoUser extends StatelessWidget {
  final Function? bloc;
  WidgetBlocInfoUser({this.bloc});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoUserBloc, InfoUserState>(
      bloc: InfoUserBloc.of(context)..add(InitDataEvent()),
      builder: (context, state) {
        if (state is UpdateInfoUserState) {
          return bloc != null ? bloc!(state.infoUser) : Container();
        }else {
          return TrailLoading(width: 100, height: 100);
        }
      },
    );
  }
}
