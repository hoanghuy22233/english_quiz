import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/utils_libs.dart';
part 'response.g.dart';

@JsonSerializable()
class ResponseStatus {
  final bool status;
  final InfoUser data;
  final String message;

  const ResponseStatus({this.status, this.data, this.message});

  static const empty =  ResponseStatus(status: true, data: null, message: '');

  factory ResponseStatus.fromJson(Map<String, dynamic> json) => _$ResponseStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseStatusToJson(this);
}

@JsonSerializable()
class ResponseDataStatus {
  final bool status;
  final Data data;
  final String message;

  const ResponseDataStatus({this.status, this.data, this.message});

  static const empty =  ResponseDataStatus(status: true, data: null, message: '');

  factory ResponseDataStatus.fromJson(Map<String, dynamic> json) => _$ResponseDataStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataStatusToJson(this);
}


@JsonSerializable()
class Data {
  final InfoUserPostImage user;

  const Data({this.user});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}