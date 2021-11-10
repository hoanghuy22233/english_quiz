import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';

class NotificationDetailScreen extends StatefulWidget {
  @override
  _NotificationDetailScreenState createState() => _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final NotificationData detailNotification = Get.arguments;
    UserNotificationBloc.of(context).add(InitUserNotificationEvent());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: WidgetBackButton(),
          ),
          title: Text(MESSAGES.DETAIL_NOTIFICATION, style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: COLORS.WHITE,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppValue.vSpaceSmall,
                Text(
                  detailNotification.title!,
                  style: AppStyle.DEFAULT_MEDIUM_BOLD,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppValue.formatStringDate(detailNotification.createdAt!) ?? DateTime.now().toString(),
                    style: AppStyle.DEFAULT_SMALLs,
                  ),
                ),
                AppValue.vSpaceSmall,
                MySeparator(
                  color: COLORS.PRIMARY_COLOR,
                ),
                AppValue.vSpaceSmall,
                HtmlWidget(
                  detailNotification.content!,
                ),
              ],
            ),
          ),
        )
    );
  }
}
