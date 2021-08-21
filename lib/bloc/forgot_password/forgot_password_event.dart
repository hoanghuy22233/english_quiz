part of 'forgot_password_bloc.dart';
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class EmailForgotPasswordChanged extends ForgotPasswordEvent {
  const EmailForgotPasswordChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailForgotPasswordUnfocused extends ForgotPasswordEvent {}

class FormForgotPasswordSubmitted extends ForgotPasswordEvent {}
