import 'package:json_annotation/json_annotation.dart';
part 'params_user.g.dart';
@JsonSerializable()
class ParamChangeInformation {
  String name, code, email, phone, address, gender;

  ParamChangeInformation(
      {
        this.name,
        this.code,
        this.email,
        this.phone,
        this.address,
        this.gender,
        });

  factory ParamChangeInformation.fromJson(Map<String, dynamic> json) => _$ParamChangeInformationFromJson(json);
  Map<String, dynamic> toJson() => _$ParamChangeInformationToJson(this);
}

@JsonSerializable()
class ParamChangeAvatar {
  String code, email, avatar;

  ParamChangeAvatar(
      {
        this.code,
        this.email,
        this.avatar,
        });

  factory ParamChangeAvatar.fromJson(Map<String, dynamic> json) => _$ParamChangeAvatarFromJson(json);
  Map<String, dynamic> toJson() => _$ParamChangeAvatarToJson(this);
}