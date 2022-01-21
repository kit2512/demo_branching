import 'dart:async';

import 'package:demo_branching/src/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  late StreamSubscription _userSubscription;
  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(
          authenticationRepository.currentUser.isEmpty
              ? const AuthenticationState.unauthenticated()
              : AuthenticationState.authenticated(
                  authenticationRepository.currentUser),
        ) {
    _userSubscription = authenticationRepository.userChanges
        .listen((user) => add(UserChangedEvent(user)));
    on<UserChangedEvent>(_onUserChanged);
    on<LogOutRequested>(_onLogOutRequested);
  }

  FutureOr<void> _onLogOutRequested(
      LogOutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(authenticationRepository.signOut());
  }

  FutureOr<void> _onUserChanged(
      UserChangedEvent event, Emitter<AuthenticationState> emit) {
    emit(event.user.isEmpty
        ? const AuthenticationState.unauthenticated()
        : AuthenticationState.authenticated(event.user));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
