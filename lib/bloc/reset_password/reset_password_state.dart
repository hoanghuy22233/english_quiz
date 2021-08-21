part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.otp = const OTPNumber.pure(),
    this.newPassword = const Password.pure(),
    this.repeatPassword = const Password.pure(),
    this.status = FormzStatus.pure,
    this.message = ''
  });

  final OTPNumber otp;
  final Password newPassword;
  final Password repeatPassword;
  final FormzStatus status;
  final String message;

  ResetPasswordState copyWith({
    OTPNumber? otp,
    Password? newPassword,
    Password? repeatPassword,
    FormzStatus? status,
    String? message
  }) {
    return ResetPasswordState(
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      repeatPassword: repeatPassword ?? this.repeatPassword,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [otp, newPassword, repeatPassword, status, message];
}
