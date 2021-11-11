import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';
part 'response_statis_result.g.dart';

@JsonSerializable()
class ResponseStatisticsData {
  bool status;
  String message;
  List<StatisticsData> data;
  ResponseStatisticsData({this.status, this.message, this.data});
  factory ResponseStatisticsData.fromJson(Map<String, dynamic> json) =>
      _$ResponseStatisticsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseStatisticsDataToJson(this);
}

@JsonSerializable()
class StatisticsData {
  int id, type,status;
  final String title;
  @JsonKey(name: "content")
  final String content;
  @JsonKey(name: "answer")
  final String answer;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "updated_at")
  final String updateAt;
  @JsonKey(name: "pivot")
  Pivots pivot;


  StatisticsData({this.id, this.type, this.status,this.title, this.content, this.answer,
    this.createdAt, this.updateAt, this.pivot});

  factory StatisticsData.fromJson(Map<String, dynamic> json) => _$StatisticsDataFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsDataToJson(this);
}

@JsonSerializable()
class Pivots {
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: "exam_id")
  final int examId;
  @JsonKey(name: "total_correct")
  final int totalCorrect;


  Pivots({this.userId, this.examId, this.totalCorrect});

  factory Pivots.fromJson(Map<String, dynamic> json) => _$PivotsFromJson(json);

  Map<String, dynamic> toJson() => _$PivotsToJson(this);
}