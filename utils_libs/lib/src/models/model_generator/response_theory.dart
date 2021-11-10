import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/src/models/model_generator/theory.dart';
import 'package:utils_libs/utils_libs.dart';
part 'response_theory.g.dart';

@JsonSerializable()
class ResponseTheoryDeatilStatus extends Equatable{
  final List<Theorys>? data;
  final Theorys? theory;

  const ResponseTheoryDeatilStatus({ this.data,this.theory,});

  ResponseTheoryDeatilStatus copyWith({List<Theorys>? data, Theorys? theory}) {
    return ResponseTheoryDeatilStatus(
      data: data ?? this.data,
      theory: theory ?? theory,
    );
  }
  @override
  List<Object> get props => [data!, theory!];

}


@JsonSerializable()
class ResponseTheoryStatus {
  final bool? status;
  final List<Theorys>? data;
  final String? message;

  const ResponseTheoryStatus({this.status, this.data, this.message});

  static const empty =  ResponseTheoryStatus(status: true, data: null, message: '');

  factory ResponseTheoryStatus.fromJson(Map<String, dynamic> json) => _$ResponseTheoryStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseTheoryStatusToJson(this);
}


@JsonSerializable()
class ResponseTheoryDeatilStatuss {
  final bool? status;
  final Theorys? data;
  final String? message;

  const ResponseTheoryDeatilStatuss({this.status, this.data, this.message});

  static const empty =  NotificationDetailResponseStatus(status: true, data: null, message: '');

  factory ResponseTheoryDeatilStatuss.fromJson(Map<String, dynamic> json) => _$ResponseTheoryDeatilStatussFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseTheoryDeatilStatussToJson(this);
}


