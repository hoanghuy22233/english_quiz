import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';
part 'response_post.g.dart';

@JsonSerializable()
class ResponsePostStatus {
  final bool? status;
  final List<PostData>? data;
  final String? message;

  const ResponsePostStatus({this.status, this.data, this.message});

  static const empty =  ResponsePostStatus(status: true, data: null, message: '');

  factory ResponsePostStatus.fromJson(Map<String, dynamic> json) => _$ResponsePostStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsePostStatusToJson(this);
}


@JsonSerializable()
class PostData {
  final int? id, type, status;
  final String? title, content;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  const PostData({this.id, this.type, this.status, this.title, this.content, this.createdAt, this.updatedAt});

  factory PostData.fromJson(Map<String, dynamic> json) => _$PostDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}