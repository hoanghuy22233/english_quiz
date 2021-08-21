part of 'login_bloc.dart';
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class CodeChanged extends LoginEvent {
  const CodeChanged({required this.code});

  final String code;

  @override
  List<Object> get props => [code];
}

class CodeUnfocused extends LoginEvent {}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends LoginEvent {}

class FormSubmitted extends LoginEvent {}
