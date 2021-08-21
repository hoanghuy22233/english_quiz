part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
  @override
  bool get stringify => true;
}


class ProfileChangedFullName extends ProfileEvent {
  final String fullName;
  const ProfileChangedFullName(this.fullName);
  @override
  List<Object> get props => [fullName];
}

class ProfileChangedGender extends ProfileEvent {
  final int gender;
  const ProfileChangedGender(this.gender);
  @override
  List<Object> get props => [gender];
}

class ProfileChangedPhone extends ProfileEvent {
  final String phone;
  const ProfileChangedPhone(this.phone);
  @override
  List<Object> get props => [phone];
}

// class ProfileChangedBirthday extends ProfileEvent {
//   final String birthday;
//   const ProfileChangedBirthday(this.birthday);
//   @override
//   List<Object> get props => [birthday];
// }

class ProfileUploadAvatar extends ProfileEvent {
  final File avatar;
  const ProfileUploadAvatar({required this.avatar});
  @override
  List<Object> get props => [avatar];
}

class ProfileChangedAddress extends ProfileEvent {
  final String address;
  const ProfileChangedAddress(this.address);
  @override
  List<Object> get props => [address];
}

class UpdateProfileEvent extends ProfileEvent{
  final InfoUser infoUser;
  const UpdateProfileEvent({required this.infoUser});
  @override
  List<Object> get props => [infoUser];
}

class LoadingProfile extends ProfileEvent {}

class FormSubmitProfileEvent extends ProfileEvent {}

class UpdateProfileSuccess extends ProfileEvent {}