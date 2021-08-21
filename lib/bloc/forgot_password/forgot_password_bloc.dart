// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:english_quiz/api_resfull/api.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository userRepository;

  ForgotPasswordBloc({required this.userRepository})
      : super(const ForgotPasswordState());

  @override
  void onTransition(Transition<ForgotPasswordEvent, ForgotPasswordState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async* {
    if (event is EmailForgotPasswordChanged) {
      final email = UserName.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : UserName.pure(event.email),
        status: Formz.validate([email]),
      );
    } else if (event is EmailForgotPasswordUnfocused) {
      final email = UserName.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email]),
      );
    } else if (event is FormForgotPasswordSubmitted) {
      try{
        if (state.status.isValidated) {
          yield state.copyWith(status: FormzStatus.submissionInProgress);
          ParamForgotPassword paramForgotPassword = ParamForgotPassword(
            email: state.email.value
          );
          var response = await userRepository.forgotPassword(paramForgotPassword: paramForgotPassword);
          if (response.status == BASE_URL.SUCCESS) {
            yield state.copyWith(status: FormzStatus.submissionSuccess, message: response.message);
          } else {
            yield state.copyWith(status: FormzStatus.submissionFailure, message: response.message);
          }
        }
      }catch(e){
        yield state.copyWith(status: FormzStatus.submissionFailure, message: MESSAGES.CONNECT_ERROR);
        throw e;
      }
    }
  }
  static ForgotPasswordBloc of(BuildContext context) => BlocProvider.of<ForgotPasswordBloc>(context);
}
