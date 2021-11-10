import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info_user.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class InfoUser extends Equatable {
  @JsonKey(name: "status")
  int? statusUser;
  int? id, gender;
  List<String>? type;
  String? name, code, otp, phone, image, address, email;
  @JsonKey(name: "device_code")
  String? deviceCode;
  @JsonKey(name: "email_verified_at")
  String? emailVerifiedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  InfoUser({this.id, this.gender, this.statusUser, this.type, this.name, this.code, this.otp, this.phone, this.image,
    this.address, this.email, this.deviceCode, this.emailVerifiedAt, this.createdAt, this.updatedAt});

  InfoUser copyWith(
      {
        int? status,
        int? id, gender, type,
        String? name, code, otp, phone, image, address, email,
        String? deviceCode,
        String? emailVerifiedAt,
        String? createdAt,
        String? updatedAt
      }) {
    return InfoUser(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      statusUser: status ?? this.statusUser,
      type: type ?? this.type,
      name: name ?? this.name,
      code: code ?? this.code,
      otp: otp ?? this.otp,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      address: address ?? this.address,
      email: email ?? this.email,
      deviceCode: deviceCode ?? this.deviceCode,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory InfoUser.fromJson(Map<String, dynamic> json) =>
      _$InfoUserFromJson(json);

  Map<String, dynamic> toJson() => _$InfoUserToJson(this);

  @override
  List<Object> get props => [
    id!, gender!, statusUser!, type!, name!, code!, otp!, phone!, image!, address!, email!, deviceCode!,
    emailVerifiedAt!, createdAt!, updatedAt!
  ];
}