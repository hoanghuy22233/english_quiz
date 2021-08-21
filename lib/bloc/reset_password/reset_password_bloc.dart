// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:english_quiz/api_resfull/user_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UserRepository userRepository;

  ResetPasswordBloc({required this.userRepository})
      : super(const ResetPasswordState());

  @override
  void onTransition(Transition<ResetPasswordEvent, ResetPasswordState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is OTPResetChanged) {
      final otp = OTPNumber.dirty(event.otp);
      yield state.copyWith(
        otp: otp.valid ? otp : OTPNumber.pure(event.otp),
        status: Formz.validate([otp, state.newPassword, state.repeatPassword]),
      );
    }

    else if (event is NewPasswordResetChanged) {
      final newPassword = Password.dirty(event.newPassword);
      yield state.copyWith(
        newPassword: newPassword.valid ? newPassword : Password.pure(event.newPassword),
        status: Formz.validate([state.otp, newPassword, state.repeatPassword]),
      );
    }

    else if (event is RepeatPasswordResetChanged) {
      final repeatPassword = Password.dirty(event.repeatPassword);
      yield state.copyWith(
        repeatPassword: repeatPassword.valid ? repeatPassword : Password.pure(event.repeatPassword),
        status: Formz.validate([state.otp, state.newPassword, repeatPassword]),
      );
    }

    else if (event is OTPResetUnfocused) {
      final otp = OTPNumber.dirty(state.otp.value);
      yield state.copyWith(
        otp: otp,
        status: Formz.validate([otp , state.newPassword, state.repeatPassword]),
      );
    }

    else if (event is NewPasswordResetUnfocused) {
      final newPassword = Password.dirty(state.newPassword.value);
      yield state.copyWith(
        newPassword: newPassword,
        status: Formz.validate([state.otp, newPassword, state.repeatPassword]),
      );
    }

    else if (event is RepeatPasswordResetUnfocused) {
      final repeatPassword = Password.dirty(state.repeatPassword.value);
      yield state.copyWith(
        repeatPassword: repeatPassword,
        status: Formz.validate([state.otp, state.newPassword, repeatPassword]),
      );
    }

    else if (event is FormResetPasswordSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        ParamResetPassword paramResetPassword = ParamResetPassword(
          otp: state.otp.value,
          newPass: state.newPassword.value,
          repeatPass: state.repeatPassword.value
        );
        try{
          var response = await userRepository.resetPassword(
              paramResetPassword: paramResetPassword
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
  static ResetPasswordBloc of(BuildContext context) => BlocProvider.of<ResetPasswordBloc>(context);
}
