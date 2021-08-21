part of 'login_bloc.dart';
class LoginState extends Equatable {
  const LoginState({
    this.code = const CodeUser.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.message = ''
  });

  final CodeUser code;
  final Password password;
  final FormzStatus status;
  final String message;

  LoginState copyWith({
    CodeUser? code,
    Password? password,
    String? message,
    FormzStatus? status,
  }) {
    return LoginState(
      code: code ?? this.code,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [code, password, status, message];
}