import 'package:english_quiz/bloc/blocs.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetUserNotificationBloc extends StatelessWidget {
  final Function blocUserNotification;
  final UserNotificationBloc? bloc;
  WidgetUserNotificationBloc({this.bloc, required this.blocUserNotification});
  @override
  Widget build(BuildContext context) => BlocBuilder<UserNotificationBloc, UserNotificationState>(
    bloc: bloc,
    builder: (context, state) {
      if (state is UpdateUserNotification) {
        return blocUserNotification(state.notification);
      } else {
        return TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2);
      }
    },
  );
}


