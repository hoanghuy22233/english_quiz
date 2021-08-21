import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';
part 'notification_response.g.dart';

class NotificationUser extends Equatable{
  final List<NotificationData> userNotification;
  final NotificationData detailNotification;
  NotificationUser({this.userNotification, this.detailNotification});
  NotificationUser copyWith({List<NotificationData> userNotification, NotificationData detailNotification}) {
    return NotificationUser(
      userNotification: userNotification ?? this.userNotification,
      detailNotification: detailNotification ?? detailNotification,
    );
  }
  @override
  List<Object> get props => [userNotification, detailNotification];
}

@JsonSerializable()
class NotificationResponseStatus {
  final bool status;
  final List<NotificationData> data;
  final String message;

  const NotificationResponseStatus({this.status, this.data, this.message});

  static const empty =  NotificationResponseStatus(status: true, data: null, message: '');

  factory NotificationResponseStatus.fromJson(Map<String, dynamic> json) => _$NotificationResponseStatusFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationResponseStatusToJson(this);
}

@JsonSerializable()
class NotificationDetailResponseStatus {
  final bool status;
  final NotificationData data;
  final String message;

  const NotificationDetailResponseStatus({this.status, this.data, this.message});

  static const empty =  NotificationDetailResponseStatus(status: true, data: null, message: '');

  factory NotificationDetailResponseStatus.fromJson(Map<String, dynamic> json) => _$NotificationDetailResponseStatusFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDetailResponseStatusToJson(this);
}

@JsonSerializable()
class NotificationSeenResponseStatus {
  final bool status;
  final bool data;
  final String message;

  const NotificationSeenResponseStatus({this.status, this.data, this.message});

  static const empty =  NotificationSeenResponseStatus(status: true, data: null, message: '');

  factory NotificationSeenResponseStatus.fromJson(Map<String, dynamic> json) => _$NotificationSeenResponseStatusFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSeenResponseStatusToJson(this);
}

@JsonSerializable()
class NotificationData extends Equatable {
  final int id, status;
  final String title, content;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "updated_at")
  final String updatedAt;
  final Pivot pivot;

  NotificationData({this.id, this.status, this.title, this.content, this.createdAt, this.updatedAt, this.pivot});

  NotificationData copyWith(
      {
        int id, status,
        String title, content,
        String createdAt,
        String updatedAt,
        Pivot pivot
      }) {
    return NotificationData(
      id: id ?? this.id,
      status: status ?? this.status,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pivot: pivot ?? this.pivot
    );
  }

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);

  @override
  List<Object> get props => [id, status, title, content, createdAt, updatedAt, pivot];
}

@JsonSerializable()
class Pivot extends Equatable {
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: "notification_id")
  final int notificationId;
  final int status;

  Pivot({this.userId, this.notificationId, this.status});

  Pivot copyWith(
      {
        int userId, notificationId, status
      }) {
    return Pivot(
      userId: userId ?? this.userId,
      status: status ?? this.status,
      notificationId: notificationId ?? this.notificationId,
    );
  }

  factory Pivot.fromJson(Map<String, dynamic> json) =>
      _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);

  @override
  List<Object> get props => [userId, status, notificationId];
}