part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final String? errorMessage;
  final FormzStatus status;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.errorMessage,
    this.status = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [email, password, errorMessage, status];

  LoginState copyWith({
    Email? email,
    Password? password,
    String? errorMessage,
    FormzStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
