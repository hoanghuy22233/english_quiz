// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationScreen extends StatefulWidget {

  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: WidgetBackButton(),
          ),
          title: Text(MESSAGES.NOTIFICATION, style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Container(
            color: COLORS.WHITE,
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      UserNotificationBloc.of(context)..add(InitUserNotificationEvent());
                      await Future.delayed(Duration(seconds: 2));
                    },
                    color: COLORS.WHITE,
                    backgroundColor: COLORS.PRIMARY_COLOR,
                    child: WidgetUserNotificationBloc(
                      bloc: UserNotificationBloc.of(context)..add(InitUserNotificationEvent()),
                      blocUserNotification: (NotificationUser noti) {
                        final List<NotificationData>? notification = noti.userNotification;
                        if(notification == null) return TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2);
                        return ListView.builder(
                          itemCount: notification.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                UserNotificationBloc.of(context).add(InitDetailNotificationEvent(notification[index].id));
                              },
                              child: WidgetItemContainer(
                                title: notification[index].title ?? MESSAGES.NOTIFICATION,
                                content: notification[index].content ?? MESSAGES.NOTIFICATION,
                                createdDate: notification[index].createdAt ?? MESSAGES.NOTIFICATION,
                                seen: notification[index].pivot.status ?? 0,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class WidgetItemContainer extends StatelessWidget {
  final String title, content, createdDate;
  final int seen;

  const WidgetItemContainer(
      {Key? key,
        required this.title,
        required this.content,
        required this.createdDate,
        required this.seen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: seen == 0 ? COLORS.LIGHT_BLUE : COLORS.LIGHT_GREY),
      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WidgetContainerImage(
            width: 70,
            height: 70,
            image: IMAGES.LOGO_APP,
          ),
          AppValue.hSpaceTiny,
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.DEFAULT_MEDIUM_BOLD,
                ),
                AppValue.vSpaceTiny,
                // Container(
                //   width: AppValue.widths*0.7,
                //   child: HtmlWidget(
                //     content.length > 10 ? '${content.substring(0, 10)} ...' :  content,
                //   ),
                // ),
                AppValue.vSpace(7),
                Text(
                  AppValue.formatStringDate(createdDate) ?? DateTime.now().toString(),
                  style: AppStyle.DEFAULT_SMALLs,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
