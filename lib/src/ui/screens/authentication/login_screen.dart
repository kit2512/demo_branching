import 'package:demo_branching/src/blocs/blocs.dart';
import 'package:demo_branching/src/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage as String),
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          _EmailInput(),
          SizedBox(height: 20),
          _PasswordInput(),
          SizedBox(height: 20),
          _LoginButton(),
          SizedBox(height: 20),
          _SocialLogin()
        ],
      ),
    );
  }
}

class _SocialLogin extends StatelessWidget {
  const _SocialLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: context.read<LoginCubit>().onSignInWithGoogle,
          child: Text("Sign in with Google"),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: context.read<LoginCubit>().onSignInWithFacebook,
          child: Text("Sign in with Facebook"),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.status == FormzStatus.invalid
                    ? null
                    : context.read<LoginCubit>().onSignInPressed,
                child: Text("Login"),
              );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
            errorText: state.password.invalid ? "Password is invalid" : null,
          ),
          obscureText: _obscureText,
          onChanged: context.read<LoginCubit>().onPasswordChanged,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Email',
            errorText: state.email.invalid ? 'Invalid email' : null,
          ),
          onChanged: context.read<LoginCubit>().onEmailChanged,
        );
      },
    );
  }
}
