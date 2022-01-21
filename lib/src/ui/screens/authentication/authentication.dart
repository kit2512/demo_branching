import 'package:demo_branching/src/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_branching/src/repositories/repositories.dart';
import 'login_screen.dart';
import 'user_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: _BuildAuthenticationView(),
    );
  }
}

class _BuildAuthenticationView extends StatelessWidget {
  const _BuildAuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return UserScreen();
      } else {
        return LoginScreen();
      }
    });
  }
}
