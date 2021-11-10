import 'package:json_annotation/json_annotation.dart';

part 'login_app_request.g.dart';

@JsonSerializable()
class LoginAppRequest {
  @JsonKey(name: "code")
  final String? code;
  final String? password;
  @JsonKey(name: "device_code")
  final String? deviceCode;
  LoginAppRequest({this.code, this.password, this.deviceCode});
  factory LoginAppRequest.fromJson(Map<String, dynamic> json) => _$LoginAppRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginAppRequestToJson(this);
}