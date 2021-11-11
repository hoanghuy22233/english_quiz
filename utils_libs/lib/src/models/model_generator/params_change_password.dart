import 'package:json_annotation/json_annotation.dart';
import 'package:utils_libs/src/models/index.dart';
part 'params_change_password.g.dart';
@JsonSerializable()
class ParamChangePassword {
  @JsonKey(name: "old_password")
  String oldPass;
  @JsonKey(name: "password_new")
  String newPass;
  @JsonKey(name: "password_new_confirmation")
  String repeatPass;

  ParamChangePassword(
      {
        this.oldPass,
        this.newPass,
        this.repeatPass,
        });

  factory ParamChangePassword.fromJson(Map<String, dynamic> json) => _$ParamChangePasswordFromJson(json);
  Map<String, dynamic> toJson() => _$ParamChangePasswordToJson(this);
}

@JsonSerializable()
class ParamForgotPassword {
  String email;

  ParamForgotPassword(
      {
        this.email,
      });

  factory ParamForgotPassword.fromJson(Map<String, dynamic> json) => _$ParamForgotPasswordFromJson(json);
  Map<String, dynamic> toJson() => _$ParamForgotPasswordToJson(this);
}

@JsonSerializable()
class ParamResetPassword {
  @JsonKey(name: "otp")
  String otp;
  @JsonKey(name: "password")
  String newPass;
  @JsonKey(name: "password_confirmation")
  String repeatPass;

  ParamResetPassword(
      {
        this.otp,
        this.newPass,
        this.repeatPass,
      });

  factory ParamResetPassword.fromJson(Map<String, dynamic> json) => _$ParamResetPasswordFromJson(json);
  Map<String, dynamic> toJson() => _$ParamResetPasswordToJson(this);
}

