part of 'post_bloc.dart';
abstract class PostEvent extends Equatable{
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class InitPostEvent extends PostEvent {
  final int type;
  InitPostEvent(this.type);
  @override
  String toString() {
    return 'InitDetailNotificationEvent{type: $type}';
  }
  List<Object> get props => [type];
}