part of 'notification_bloc.dart';
abstract class UserNotificationEvent extends Equatable{
  const UserNotificationEvent();
  @override
  List<Object?> get props => [];
}

class InitUserNotificationEvent extends UserNotificationEvent {}

class InitDetailNotificationEvent extends UserNotificationEvent {
  final int notiId;
  InitDetailNotificationEvent(this.notiId);
  @override
  String toString() {
    return 'InitDetailNotificationEvent{notiId: $notiId}';
  }
  List<Object> get props => [notiId];
}