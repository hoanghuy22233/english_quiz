import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';

part 'theory.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Theorys extends Equatable {
  int? id, type, status;
  String? title, content;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Theorys(
      {this.id,
      this.type,
      this.status,
      this.title,
      this.content,
      this.createdAt,
      this.updatedAt});

  Theorys copyWith(
      {int? id,
      type,
      status,
      String? title,
      content,
      String? createdAt,
      String? updatedAt}) {
    return Theorys(
      id: id ?? this.id,
      status: status ?? this.status,
      type: type ?? this.type,
      title: title??this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Theorys.fromJson(Map<String, dynamic> json) => _$TheorysFromJson(json);
  Map<String, dynamic> toJson() => _$TheorysToJson(this);

  @override
  List<Object> get props => [
        id!,status!,type!,title!,content!,
        createdAt!,
        updatedAt!
      ];
}
