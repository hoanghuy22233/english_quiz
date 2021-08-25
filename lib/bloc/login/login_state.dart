part of 'login_bloc.dart';
class LoginState extends Equatable {
  const LoginState({
    this.code = const CodeUser.pure(),
    this.password = const Password.pure(),
    this.deviceCode = const NotNull.pure(),
    this.status = FormzStatus.pure,
    this.message = ''
  });

  final CodeUser code;
  final Password password;
  final NotNull deviceCode;
  final FormzStatus status;
  final String message;

  LoginState copyWith({
    CodeUser? code,
    Password? password,
    NotNull? deviceCode,
    String? message,
    FormzStatus? status,
  }) {
    return LoginState(
      code: code ?? this.code,
      password: password ?? this.password,
      deviceCode: deviceCode ?? this.deviceCode,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [code, password, deviceCode, status, message];
}