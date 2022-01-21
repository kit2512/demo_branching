part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

@immutable
class AuthenticationState {
  final User user;
  final AuthenticationStatus status;

  const AuthenticationState._({required this.status, this.user = User.empty});

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
}
