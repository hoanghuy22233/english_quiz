import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';

part 'questions.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Questions extends Equatable {
  int id, type, status;
  @JsonKey(name: "exam_id")
  int examId;
  String title, content, answer, note;
  @JsonKey(name: "incorrect_answer")
  List<dynamic> incorrectAnswers;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;

  Questions(
      {this.id,
      this.type,
      this.status,
      this.examId,
      this.title,
      this.content,
      this.incorrectAnswers,
      this.answer,this.note,
      this.createdAt,
      this.updatedAt});

  Questions copyWith({
    int id,
    type,
    status,
    int examId,
    String title,
    content,
    answer,note,
    List<dynamic> incorrectAnswers,
    String createdAt,
    String updatedAt,
  }) {
    return Questions(
      id: id ?? this.id,
      status: status ?? this.status,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      incorrectAnswers:incorrectAnswers??this.incorrectAnswers,
      examId: examId ?? this.examId,
      answer: answer ?? this.answer,
      note: note??this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionsToJson(this);

  @override
  List<Object> get props => [
        id,
        status,
        type,
        title,
        content,
    incorrectAnswers,
        examId,
        answer,note,
        createdAt,
        updatedAt
      ];
}
