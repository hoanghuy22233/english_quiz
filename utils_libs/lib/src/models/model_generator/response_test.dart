import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/src/models/model_generator/test.dart';
import 'package:utils_libs/src/models/model_generator/theory.dart';
import 'package:utils_libs/utils_libs.dart';
part 'response_test.g.dart';
@JsonSerializable()
class ResponseTests {
  bool status;
  String message;
  List<Tests> data;
  ResponseTests({this.status, this.message, this.data});
  factory ResponseTests.fromJson(Map<String, dynamic> json) =>
      _$ResponseTestsFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseTestsToJson(this);
}


