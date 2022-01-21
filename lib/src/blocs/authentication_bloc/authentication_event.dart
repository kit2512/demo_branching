part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class UserChangedEvent extends AuthenticationEvent {
  final User user;

  const UserChangedEvent(this.user);

  @override
  List<Object> get props => [user];
}

class LogOutRequested extends AuthenticationEvent {}
