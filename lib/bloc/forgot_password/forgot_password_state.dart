part of 'forgot_password_bloc.dart';
class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = const UserName.pure(),
    this.status = FormzStatus.pure,
    this.message = ''
  });

  final UserName email;
  final FormzStatus status;
  final String message;

  ForgotPasswordState copyWith({
    UserName? email,
    FormzStatus? status,
    String? message
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [email, status, message];
}
