import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';
part 'response_post_result.g.dart';

@JsonSerializable()
class ResponsePostResultStatus {
  final bool status;
  final PostResultData data;
  final String message;

  const ResponsePostResultStatus({this.status, this.data, this.message});

  static const empty =  ResponsePostStatus(status: true, data: null, message: '');

  factory ResponsePostResultStatus.fromJson(Map<String, dynamic> json) => _$ResponsePostResultStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsePostResultStatusToJson(this);
}

@JsonSerializable()
class PostResultData {
  @JsonKey(name: "total_correct")
  final String totalCorrect;
  @JsonKey(name: "total_wrong")
  final String totalWrong;
  final String percent;
  final int total;


  PostResultData({this.totalCorrect, this.totalWrong, this.percent, this.total,});

  factory PostResultData.fromJson(Map<String, dynamic> json) => _$PostResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostResultDataToJson(this);
}