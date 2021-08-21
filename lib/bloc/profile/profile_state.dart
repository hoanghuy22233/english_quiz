part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  ProfileState({required this.infoUser, this.isLoading});
  ProfileState.initial() : this(
      infoUser: InfoUser(
        statusUser: 1,
        id: 1,
        gender: 1,
        type: 1,
        name: null,
        code: null,
        otp: null,
        phone: null,
        image: null,
        address: null,
        email: null,
        emailVerifiedAt: null,
        createdAt: null,
        updatedAt: null,
      ),
      isLoading: false
  );
  final InfoUser? infoUser;
  final bool? isLoading;
  ProfileState copyWith({InfoUser? infoUser, bool? isLoading}) {
    return ProfileState(
      infoUser: infoUser ?? this.infoUser,
      isLoading: isLoading ?? this.isLoading,
    );
  }
  @override
  List<Object?> get props => [infoUser, isLoading];
}