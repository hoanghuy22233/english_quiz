import 'package:english_quiz/storages/share_local.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'dart:io';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final InfoUserBloc blocInfo;
  StreamSubscription? blocInfoSubscription;
  final UserRepository? _userRepository;

  ProfileBloc(
      {this.blocInfoSubscription,
        required this.blocInfo,
        UserRepository? userRepository})
      : _userRepository = userRepository,
        super(ProfileState.initial()) {
    void onTodoStateChanged(state) {
      if (state is UpdateInfoUserState) {
        add(UpdateProfileEvent(infoUser: state.infoUser));
      }
    }

    onTodoStateChanged(blocInfo.state);
    blocInfoSubscription = blocInfo.stream.listen(onTodoStateChanged);
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateProfileEvent) {
      yield state.copyWith(infoUser: event.infoUser);
    } else if (event is ProfileChangedFullName) {
      yield state.copyWith(infoUser: state.infoUser!.copyWith(name: event.fullName));
    } else if (event is ProfileChangedGender) {
      yield state.copyWith(infoUser: state.infoUser!.copyWith(gender: event.gender));
    } else if (event is ProfileChangedPhone) {
      yield state.copyWith(infoUser: state.infoUser!.copyWith(phone: event.phone));
    } else if (event is ProfileChangedAddress) {
      yield state.copyWith(infoUser: state.infoUser!.copyWith(address: event.address));
    } else if (event is ProfileUploadAvatar) {
      try {
        final code = state.infoUser!.code;
        final email = state.infoUser!.email;
        final name = state.infoUser!.name;

        final response = await _userRepository!.postImage(file: event.avatar, code: code, email: email, name: name);

        if (response.status == BASE_URL.SUCCESS) {
          yield state.copyWith(isLoading: false);
          await GetSnackBarUtils.createSuccess(message: response.message);
          await shareLocal.putString(PreferencesKey.USER_CODE, response.data.user.code);
          await shareLocal.putString(PreferencesKey.USER_EMAIL, response.data.user.email);
          blocInfo.add(InitDataEvent());
          blocInfo.add(AddDataEvent());
        } else {
          yield state.copyWith(isLoading: false);
          await GetSnackBarUtils.createFailure(message: response.message);
        }
      } catch (e) {
        yield state.copyWith(isLoading: false);
        await GetSnackBarUtils.createFailure(message: MESSAGES.CONNECT_ERROR);
        throw (e);
      }

    } else if (event is FormSubmitProfileEvent) {
      try {
        final response = await _userRepository!.postUpdateProfile(infoUser: state.infoUser!);
        if (response.status == BASE_URL.SUCCESS) {
          yield state.copyWith(isLoading: false);
          await GetSnackBarUtils.createSuccess(message: response.message);
          AppNavigator.navigateBack();
          blocInfo.add(InitDataEvent());
          blocInfo.add(AddDataEvent());
        } else {
          yield state.copyWith(isLoading: false);
          await GetSnackBarUtils.createFailure(message: response.message);
        }
      } catch (e) {
        yield state.copyWith(isLoading: false);
        await GetSnackBarUtils.createFailure(message: MESSAGES.CONNECT_ERROR);
      }
    }
  }

  @override
  Future<void> close() {
    blocInfoSubscription!.cancel();
    return super.close();
  }
  static ProfileBloc of(BuildContext context) => BlocProvider.of<ProfileBloc>(context);
}