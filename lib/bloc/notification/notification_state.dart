part of 'notification_bloc.dart';
abstract class UserNotificationState extends Equatable{
  const UserNotificationState();
  @override
  List<Object?> get props => [];
}

class UpdateUserNotification extends UserNotificationState{
  final NotificationUser notification;
  UpdateUserNotification({required this.notification});
  UpdateUserNotification.initial() : this(notification: NotificationUser(userNotification: [], detailNotification: NotificationData()));
  @override
  List<Object> get props => [notification];
}
