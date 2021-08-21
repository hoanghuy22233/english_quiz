// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:english_quiz/api_resfull/api.dart';
import 'package:english_quiz/storages/storages.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final EventRepositoryStorage localRepository;

  LoginBloc({required this.userRepository, required this.localRepository})
      : super(const LoginState());

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is CodeChanged) {
      final code = CodeUser.dirty(event.code);
      yield state.copyWith(
        code: code.valid ? code : CodeUser.pure(event.code),
        status: Formz.validate([code, state.password]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.code, password]),
      );
    } else if (event is CodeUnfocused) {
      final code = CodeUser.dirty(state.code.value);
      yield state.copyWith(
        code: code,
        status: Formz.validate([code, state.password]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.code, password]),
      );
    } else if (event is FormSubmitted) {
      try{
        if (state.status.isValidated) {
          yield state.copyWith(status: FormzStatus.submissionInProgress);
          var response = await userRepository.loginApp(code: state.code.value, password: state.password.value);
          if (response.status == BASE_URL.SUCCESS) {
            await localRepository.saveUser(jsonEncode(response));
            await shareLocal.putString(PreferencesKey.TOKEN, response.data.token);
            await shareLocal.putString(PreferencesKey.USER_CODE, response.data.user.code);
            await shareLocal.putString(PreferencesKey.USER_EMAIL, response.data.user.email);
            await shareLocal.putInt(PreferencesKey.USER_TYPE, response.data.user.type);
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
  static LoginBloc of(BuildContext context) => BlocProvider.of<LoginBloc>(context);
}
