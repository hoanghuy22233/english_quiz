import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';
part 'response_detail_question.g.dart';
@JsonSerializable()
class ResponseDetailQuestion {
  bool status;
  String message;
  detailData data;
  ResponseDetailQuestion({this.status, this.message, this.data});
  factory ResponseDetailQuestion.fromJson(Map<String, dynamic> json) =>
      _$ResponseDetailQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDetailQuestionToJson(this);
}

@JsonSerializable()
// ignore: camel_case_types, must_be_immutable
class detailData extends Equatable {
  @JsonKey(name:"questions_1" )

  List<Questions> question;

  detailData(this.question);

  factory detailData.fromJson(Map<String, dynamic> json) => _$detailDataFromJson(json);

  Map<String, dynamic> toJson() => _$detailDataToJson(this);

  @override
  List<Object> get props => [question];
}



