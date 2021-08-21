// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:english_quiz/api_resfull/user_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;

  ChangePasswordBloc({required this.userRepository})
      : super(const ChangePasswordState());

  @override
  void onTransition(Transition<ChangePasswordEvent, ChangePasswordState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ChangePasswordState> mapEventToState(ChangePasswordEvent event) async* {
    if (event is OldPasswordChanged) {
      final oldPassword = Password.dirty(event.oldPassword);
      yield state.copyWith(
        oldPassword: oldPassword.valid ? oldPassword : Password.pure(event.oldPassword),
        status: Formz.validate([oldPassword, state.newPassword, state.repeatPassword]),
      );
    }

    else if (event is NewPasswordChanged) {
      final newPassword = Password.dirty(event.newPassword);
      yield state.copyWith(
        newPassword: newPassword.valid ? newPassword : Password.pure(event.newPassword),
        status: Formz.validate([state.oldPassword, newPassword, state.repeatPassword]),
      );
    }

    else if (event is RepeatPasswordChanged) {
      final repeatPassword = Password.dirty(event.repeatPassword);
      yield state.copyWith(
        repeatPassword: repeatPassword.valid ? repeatPassword : Password.pure(event.repeatPassword),
        status: Formz.validate([state.oldPassword, state.newPassword, repeatPassword]),
      );
    }

    else if (event is OldPasswordUnfocused) {
      final oldPassword = Password.dirty(state.oldPassword.value);
      yield state.copyWith(
        oldPassword: oldPassword,
        status: Formz.validate([oldPassword , state.newPassword, state.repeatPassword]),
      );
    }

    else if (event is NewPasswordUnfocused) {
      final newPassword = Password.dirty(state.newPassword.value);
      yield state.copyWith(
        newPassword: newPassword,
        status: Formz.validate([state.oldPassword, newPassword, state.repeatPassword]),
      );
    }

    else if (event is RepeatPasswordUnfocused) {
      final repeatPassword = Password.dirty(state.repeatPassword.value);
      yield state.copyWith(
        repeatPassword: repeatPassword,
        status: Formz.validate([state.oldPassword, state.newPassword, repeatPassword]),
      );
    }

    else if (event is FormChangePasswordSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        ParamChangePassword paramChangePassword = ParamChangePassword(
          newPass: state.newPassword.value,
          oldPass: state.oldPassword.value,
          repeatPass: state.repeatPassword.value
        );
        try{
          var response = await userRepository.changePassword(
              paramChangePassword: paramChangePassword
          );
          if (response.status == BASE_URL.SUCCESS) {
            yield state.copyWith(status: FormzStatus.submissionSuccess, message: response.message);
          } else {
            yield state.copyWith(status: FormzStatus.submissionFailure, message: response.message);
          }
        }catch(e){
          yield state.copyWith(status: FormzStatus.submissionFailure, message: MESSAGES.CONNECT_ERROR);
          throw e;
        }
      }
    }
  }
  static ChangePasswordBloc of(BuildContext context) => BlocProvider.of<ChangePasswordBloc>(context);
}
