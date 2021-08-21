import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/src/models/model_generator/questions.dart';
import 'package:utils_libs/utils_libs.dart';

part 'test.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Tests extends Equatable {
  int id, type, status;
  String title, content;
  dynamic answer;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  List<Questions> questions;

  Tests(
      {this.id,
      this.type,
      this.status,
      this.title,
      this.content,

        this.answer,
      this.createdAt,
      this.updatedAt,this.questions});

  Tests copyWith(
      {int id,
      type,
      status,
      String title,
      content,
        List<String> answer,
      String createdAt,
      String updatedAt,
        List<Questions> questions}) {
    return Tests(
      id: id ?? this.id,
      status: status ?? this.status,
      type: type ?? this.type,
      title: title??this.title,
      content: content ?? this.content,
      answer: answer??this.answer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      questions: questions??this.questions
    );
  }

  factory Tests.fromJson(Map<String, dynamic> json) => _$TestsFromJson(json);
  Map<String, dynamic> toJson() => _$TestsToJson(this);

  @override
  List<Object> get props => [
        id,status,type,title,content,answer,
        createdAt,
        updatedAt,questions
      ];
}
